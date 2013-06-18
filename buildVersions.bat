@echo off
build.rb -o "BuildOutput/Akari.biliScript"
build.rb -o "BuildOutput/Akari.Debug.biliScript" -v "debug" -def "DEBUG=true;"
build.rb -o "BuildOutput/Akari.Essence.biliScript" -v "essence" -def "INCL_ANIM=false;INCL_TEXT=false;INCL_FX=false;INCL_THREE=false;INCL_VECTOR=false;INCL_RAND=false;INCL_SHAND=false;"

build.rb -o "BuildOutput/Akari.min.biliScript" -strip comments
build.rb -o "BuildOutput/Akari.Essence.min.biliScript" -v "essence" -def "INCL_ANIM=false;INCL_TEXT=false;INCL_FX=false;INCL_THREE=false;INCL_VECTOR=false;INCL_RAND=false;INCL_SHAND=false;" -strip comments