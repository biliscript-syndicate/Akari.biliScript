require "io/console"

arguments = {}
while ARGV.size > 0
  arg_name = ARGV.shift.to_s.downcase;
  arg_value = ARGV.shift;
  arguments[ arg_name ] = arg_value;
end

template_file = arguments[ "-t" ] || arguments[ "-template" ] || "Akari.Template.biliScript"
namespace_dir = arguments[ "-n" ] || arguments[ "-namespaces" ] || "Namespaces"
output_file = arguments[ "-o" ] || arguments[ "-output" ] || template_file.sub( ".Template", "" )
strip_comments = arguments[ "-s" ] || arguments[ "-strip" ]
version_postfix = arguments[ "-v" ] || arguments[ "-version" ] || ""

defines = {}
if arguments[ "-def" ]
  defs = arguments[ "-def" ].split( ";" )
  defs.each do |s|
    kvp = s.split( "=" )
    defines[ kvp[ 0 ] ] = kvp[ 1 ]
  end
end

if FileTest.exists?( template_file )

  if File.directory?( namespace_dir )

    template_string = nil

    File.open( template_file, "r:utf-8" ) do |f|
      template_string = f.read
    end

    namespaces = Dir.entries( namespace_dir )
    namespaces = namespaces[ 2 .. namespaces.size ]

    # read namespaces
    namespaces.map! do |fn|
      path = File.join( namespace_dir, fn )

      File.open( path, "r:utf-8" ) do |f|
        code = f.read

        metadata = {}
        code.gsub!( /^\s*\/\/ {{([a-zA-Z0-9]+?) : ([^\/]+?)}} \/\/\s*$/ ) do |m|
          metadata[ $1 ] = [] if !metadata.has_key?( $1 )
          metadata[ $1 ].push( $2 )

          next ""
        end

        { "code" => code, "metadata" => metadata, "name" => File.basename( fn, File.extname( fn ) ) }
      end
    end

    namespaces.sort! do | a, b |
      firstDepend = a[ "metadata" ].has_key?( "Depend" ) && a[ "metadata" ][ "Depend" ].include?( b[ "name" ] )
      secondDepend = a[ "metadata" ].has_key?( "Depend" ) && a[ "metadata" ][ "Depend" ].include?( b[ "name" ] )

      next 1 if firstDepend
      next -1 if secondDepend

      next a[ "name" ] <=> b[ "name" ]
    end

    replace_hash = {
      "Version" => "v" + Time.now.strftime( "%Y%m%d" ) + " " + version_postfix,
      "Year" => Time.new.strftime( "%Y" ),
      "Rightholder" => "",
      "Namespaces" => ""
    }

    rightholders = []

    namespaces.each do |i|
      replace_hash[ "Namespaces" ] << ( i[ "code" ] + "\n" )

      if i[ "metadata" ].has_key?( "Rightholder" )
        i[ "metadata" ][ "Rightholder" ].each do |rh|
          if !rightholders.include?( rh )
            rightholders.push( rh )
          end
        end
      end
    end

    rightholders.sort!
    rightholders.each do |rh|
      replace_hash[ "Rightholder" ] << ( rh + ", " )
    end
    replace_hash[ "Rightholder" ] = replace_hash[ "Rightholder" ][ 0, replace_hash[ "Rightholder" ].size - 2 ]

    template_string.gsub!( /{{AkariTemplate : ([a-zA-Z0-9]+?)}}/ ) do |match|
      if replace_hash.has_key?( $1 )
        next replace_hash[ $1 ]
      else
        next ""
      end
    end

    # handle conditional directives
    conditional_regex = %r{
      (?<condition_type>
        DEF|NDEF|IST|ISF|NT|NF|EVAL
      ){0}

      (?<ifblock>
        ^\s* ////\#IF \s+ \(\s* \g<condition_type> \s+ (?<condition>[^\n]*?) \) \s* $\n

        (?<codeblock>
          ((?! \g<ifblock> ) .)*?
        )

        (
          ^\s* ////\#ELSE \s* $\n

          (?<elsecodeblock>
            ((?! \g<ifblock> ) .)*?
          )
        )?

        ^\s* ////\#ENDIF \s* $
      )
    }mx

    s = true
    while s
      s = template_string.sub!( conditional_regex ) do |m|

        match = $~

        case match[ "condition_type" ]
        when "DEF"
          statement_true = defines.has_key?( match[ "condition" ] )
        when "NDEF"
          statement_true = !defines.has_key?( match[ "condition" ] )
        when "IST"
          statement_true = ( defines[ match[ "condition" ] ].to_s.downcase == "true" )
        when "ISF"
          statement_true = ( defines[ match[ "condition" ] ].to_s.downcase == "false" )
        when "NT"
          statement_true = ( defines[ match[ "condition" ] ].to_s.downcase != "true" )
        when "NF"
          statement_true = ( defines[ match[ "condition" ] ].to_s.downcase != "false" )
        when "EVAL"
          statement_true = eval( match[ "condition" ] )
        end

        if statement_true
          next match[ "codeblock" ]
        else
          next match[ "elsecodeblock" ]
        end

      end
    end

    if strip_comments
      # exempt first block comment (license)
      first_block = nil
      template_string.gsub!( /\/\*.*?\*\//m ) do |s|
        if !first_block
          first_block = s
        end
        next ""
      end

      template_string.gsub!( /\/\/.*?$/m, "" )
      template_string.gsub!( /\s*([;:,+\-*\/={}()\[\]])\s*/ ) do |s|
        next $1
      end
      template_string.gsub!( /\s{2,}/, " " );

      # prevent lines from goint too long
      splitted = template_string.split( ";" )
      template_string = ""
      current_length = 0
      splitted.each do |seg|
        current_length += seg.length
        if current_length > 1000
          current_length = 0
          template_string << ( seg + ";\n" )
        else
          template_string << ( seg + ";" )
        end
      end

      template_string = first_block.to_s + template_string
    end

    File.open( output_file, "wb:utf-8" ) do |f|
      f.write( template_string )
    end

  else
    IO.console.printf "Specified namespace directory not existent.\n"
  end

else
  IO.console.printf "Specified template file does not exist.\n"
end