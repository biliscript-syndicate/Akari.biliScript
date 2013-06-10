require "io/console"

template_file = ARGV.shift || "Akari.Template.biliScript"
namespace_dir = ARGV.shift || "Namespaces"
output_file = ARGV.shift || template_file.sub( ".Template", "" )

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
      "Version" => "v" + Time.now.strftime( "%Y%m%d" ),
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

    File.open( output_file, "wb:utf-8" ) do |f|
      f.write( template_string )
    end

  else
    IO.console.printf "Specified namespace directory not existent.\n"
  end

else
  IO.console.printf "Specified template file does not exist.\n"
end