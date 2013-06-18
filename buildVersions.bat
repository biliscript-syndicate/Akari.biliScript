@echo off
build.rb 
build.rb -o "Akari.Debug.biliScript" -def "DEBUG=true;"
build.rb -o "Akari.Essence.biliScript" -def "INCL_ANIM=false;INCL_TEXT=false;INCL_FX=false;INCL_THREE=false;INCL_VECTOR=false;INCL_RAND=false;INCL_SHAND=false;"