@echo off

:: defines:
:: DEBUG       - [false] performance analysis
:: PERF_VISUAL - [false] (DEBUG) show performance graph
:: INCL_ANIM   - [ true] includes Akari.Animation
:: INCL_SPLN   - [ true] (INCL_ANIM) includes spline related classes
:: INCL_TEXT   - [ true] includes Akari.Display.Text. When off a shorthand to TextField is provided
:: INCL_FX     - [ true] includes Akari.Display.Effects
:: INCL_THREE  - [ true] includes Akari.Display.Three
:: INCL_COLOR  - [ true] includes Akari.Utilties.Color. When off other classes that depend on this might also get removed.
:: INCL_VECTOR - [ true] includes Akari.Utilties.Vector. When off other classes that depend on this might also get removed.
:: INCL_RAND   - [ true] includes Akari.Utilties.Randomizer. When off other classes that depend on this might also get removed.
:: INCL_SHAND  - [ true] includes Checkerboard and Anchors.

build.rb -o "BuildOutput/Akari.biliScript"
build.rb -o "BuildOutput/Akari.min.biliScript" -strip comments
build.rb -o "BuildOutput/Akari.Essence.min.biliScript" -v "essence" -def "INCL_ANIM=false;INCL_TEXT=false;INCL_FX=false;INCL_THREE=false;INCL_COLOR=false;INCL_VECTOR=false;INCL_RAND=false;INCL_SHAND=false;" -strip comments
build.rb -o "BuildOutput/Akari.Debug.biliScript" -v "debug" -def "DEBUG=true;PERF_VISUAL=true;"