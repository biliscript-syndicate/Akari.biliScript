Akari.Display.Effects.TrackMatte
================================

类。继承Akari.Display.Layer。

用一个层作为另一个的遮罩。要使用这一效果，只需将其插入到原本层的位置并加上遮罩层。

TrackMatte( params )
--------------------

* params

    * layer

        Akari.Display.Layer。要被遮罩的层。

    * mask

        Akari.Display.Layer。遮罩层。

* 返回

    TrackMatte。

Akari.Display.Effects.ForceMotionBlur
=====================================

类。继承Akari.Display.Layer。

应用强制运动模糊。要使用这一效果，只需将其插入到原本层的位置，并将原本的层构造器改造为使用Factory.replicate。

ForceMotionBlur( params )
-------------------------

* params

    * layers

        Array。要使用的Akari.Display.Layer的数组。它们应该是使用Factory.replicate构造的完全相同的层，除非在追求一些特殊效果。

    * exposureTime

        可选。默认为8.3333（1000 / 120）。

        Number。曝光时间。为了自然的效果，应该设定为1000除以帧率的双倍。

    * shutterPhase

        可选。默认为-90。

        Number。快门相位，以度为单位。

* 返回

    ForceMotionBlur。