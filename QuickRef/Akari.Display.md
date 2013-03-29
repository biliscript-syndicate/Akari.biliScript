Akari.Display.Layer
===================

类。

表示合成中的一层。

Layer( params )
---------------

* params

    * source

        DisplayObject。层的来源。

    * inPoint

        Number。层的进入点（毫秒）。

    * outPoint

        Number。层的退出点（毫秒）。

    * properties

        可选。默认为{}。

        Object。属性对象。

* 返回

    Layer。

Layer#update( time )
--------------------

更新层以与时间轴相合。

* 参数

    * time

        Number。合成时间轴上的当前时间（毫秒）。

Layer#getBinderScope()
----------------------

动态地返回自身以用作执行上下文。

* 返回

    Layer。this。

Layer#clone()
-------------

专用复制函数。

* 返回

    Layer。this的复制。

Akari.Display.DynamicSourceLayer
================================

类。继承Layer。

表示具有动态（需要根据时间轴更新）来源的层。

DynamicSourceLayer( params )
----------------------------

* params

    * provider

        DynamicLayerSourceProvider。层的来源提供者。

    * inPoint

        Number。层的进入点（毫秒）。

    * outPoint

        Number。层的退出点（毫秒）。

    * inPointTime

        可选。默认为provider.startTime。

        Number。层的进入点（毫秒）时来源时间轴上的时间（毫秒）。

    * outPointTime

        可选。默认为provider.startTime + provider.duration。

        Number。层的退出点（毫秒）时来源时间轴上的时间（毫秒）。

    * timeRemap

        可选。默认为null。

        Function( time )。

        * 参数

            * time

                Number。原时间。

        * 返回

            Number。经过时间重映后的时间。

    * properties

        可选。默认为{}。

        Object。属性对象。

* 返回

    DynamicSourceLayer。

Akari.Display.DynamicLayerSourceProvider
========================================

接口。

动态层来源的提供者均应实现此接口。由于JavaScript特性，这个接口没有也不必在代码中定义。

DynamicLayerSourceProvider#startTime
------------------------------------

Number。动态层来源时间轴的起始时间。

DynamicLayerSourceProvider#duration
-----------------------------------

Number。动态层来源时间轴的持续时间。

DynamicLayerSourceProvider#canvas
---------------------------------

DisplayObject。受管理的层来源。

DynamicLayerSourceProvider#update( time )
-----------------------------------------

更新来源以符合时间轴。

* 参数

    * time

        Number。当前时间（毫秒）。

Akari.Display.Composition
=========================

类。实现DynamicLayerSourceProvider。

表示一个合成。

Composition( params )
---------------------

* params

    * width

        可选。默认为$.width。

        Number。合成的指名宽度。

    * height

        可选。默认为$.height。

        Number。合成的指名高度。

    * startTime

        可选。默认为0。

        Number。合成时间轴的开始时间。

    * duration

        可选。默认为60000。

        Number。合成时间轴的持续时间。

    * layers

        可选。默认为[]。

        Array。合成中由下至上各Layer的数组。

    * hasBoundaries

        可选。默认为false。

        Boolean。是否要在合成上放置等同于舞台大小的矩形遮罩。

* 返回

    Composition。

Composition#clone()
-------------------

专用复制函数。

* 返回

    Composition。this的复制。

Akari.Display.MainComposition
=============================

类。继承Composition。

表示主合成。

Akari.Display.Animation
=======================

类。实现DynamicLayerSourceProvider。

表示一个逐帧动画。

Animation( params )
-------------------

* params

    * frames

        Array。用于绘制各帧的Function( graphics )的数组。

    * frameRate

        可选。默认为12。

        逐帧动画播放的帧速率。请注意在高度复杂的场景下使用高帧率很可能造成性能问题。

* 返回

    Animation。

Akari.Display.Sprite
====================

类。Flash Sprite的捷径。一般不直接使用。

事实上是CommentCanvas，但仅建议使用Sprite特性。

Akari.Display.Shape
===================

类。Flash Shape的捷径。

Akari.Display.Text
==================

类。Flash TextField的捷径。

事实上是CommentField，但仅使用TextField特性。不建议用于显示文字。

Text( preserveGlow )
--------------------

* 参数

    * preserveGlow

        可选。默认为false。

        是否保留原本的发光滤镜。

* 返回

    Text。

Akari.Display.Solid
===================

类。继承Shape。

一个固态层来源。

Solid( params )
---------------

* params

    * width

        Number。宽度。

    * height

        Number。高度。

    * color

        Number。色彩。

* 返回

    Solid。

Akari.Display.Checkerboard
==========================

类。继承Shape。

一个棋盘格层来源。

Checkerboard( params )
----------------------

* params

    * width

        Number。宽度。

    * height

        Number。高度。

    * frequencyX

        Number。X轴上的色块个数。

    * frequencyY

        Number。Y轴上的色块个数。

    * color1
    * color2

        Number。前景和背景色彩。

* 返回

    Checkerboard。

Akari.Display.Anchor
====================

类。继承Sprite。

改变一个DisplayObject的锚点的层来源。由于Flash不能方便地设定旋转、缩放等变换的原点，使用这个类可能会简化动画进程。

Anchor( params )
----------------

* params

    * source

        DisplayObject。原层来源。

    * x

        可选。默认source.width / 2。

        Number。X轴锚点位置。

    * y

        可选。默认source.height / 2。

        Number。Y轴锚点位置。

* 返回

    Anchor。

Akari.Display.Anchor3D
======================

类。继承Sprite。

3D空间内改变一个DisplayObject的锚点的层来源。

Anchor3D( params )
------------------

* params

    * source

        DisplayObject。原层来源。

    * x

        可选。默认source.width / 2。

        Number。X轴锚点位置。

    * y

        可选。默认source.height / 2。

        Number。Y轴锚点位置。

    * z

        可选。默认0。

        Number。Z轴锚点位置。

* 返回

    Anchor3D。