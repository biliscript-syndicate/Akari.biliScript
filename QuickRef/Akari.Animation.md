Akari.Animation.Interpolation
=============================

静态类。

包含一些插值和相关辅助函数。

dimension( interpolation )
--------------------------

基于原有的插值函数给出一个多维的插值函数。

* 参数

    * interpolation

        Function( t, value1, value2 )。原有的插值函数。

* 返回

    Function( t, value1, value2 )。可以用于多维的版本。

bezier( cpS, cpD )
------------------

产生一个二次或以上贝塞尔曲线的插值函数。昂贵。

* 参数

    * cpS

        Array。各个控制点在源-t轴上的坐标。

    * cpD

        Array。各个控制点在目标-t轴上的坐标。

* 返回

    Function( t, value1, value2 )。结果的插值函数。

hold
----

Function( t, value1, value2 )。保持value1。

linear
------

Function( t, value1, value2 )。线性在value1和value2间过渡。

cubic
-----

Object。以立方形式插值。

* easeIn

    Function( t, value1, value2 )。缓入变体。

* easeOut

    Function( t, value1, value2 )。缓出变体。

* easeInOut

    Function( t, value1, value2 )。缓入且缓出变体。

* easeOutIn

    Function( t, value1, value2 )。逆缓入且逆缓出变体。

quartic
-------

Object。四次方形式。参见cubic。

quintic
-------

Object。五次方形式。参见cubic。

exponential
-----------

Object。指数形式。参见cubic。

back
----

Object。溢出反弹形式。参见cubic。

* s

    默认1.70158。反弹用参数。

Akari.Animation.KeyframeMode
============================

枚举。

决定关键帧间插值的方式。

affectNext
----------

这个关键帧和下一个之间使用此关键帧的插值函数。

useNext
-------

这个关键帧和下一个之间使用下个关键帧的插值函数。

weightBlend
-----------

这个关键帧和下一个之间使用两者插值函数的返回值的加权平均，由这个关键帧的插值函数过渡到下一个关键帧的插值函数。

Akari.Animation.Keyframe
========================

类。

表示一个关键帧。

Keyframe( params )
------------------

* params

    * time

        Number。当关键帧所在时间。

    * value

        Object。当关键帧的值。

    * interpolation

        可选。默认Interpolation.linear。

        Function( t, value1, value2 )。当关键帧的插值函数。

    * mode

        可选。默认KeyframeMode.affectNext。

        KeyframeMode。当关键帧的插值表现。

    * weight

        可选。默认1。

        当使用KeyframeMode.weightBlend时的权值。

* 返回

    Keyframe。


Akari.Animation.KeyframesBindMode
=================================

枚举。

决定KeyframesBind的出界表现。

hold
----

出界时保持最近的关键帧的值。

repeat
------

在出界时重复关键帧（最后一个到第二个）。

pingPong
--------

在出界时往返关键帧。

Akari.Animation.KeyframesBind
=============================

类。

表示一个属性的关键帧运动。

KeyframesBind( params )
-----------------------

* params

    * keyframes

        Array。Keyframe的数组。

    * mode

        可选。默认KeyframesBindMode.hold。

        出界表现。

* 返回

    Function( time )。

Akari.Animation.WiggleKeyframes
===============================

类。

创建一系列的摇晃的关键帧。

WiggleKeyframes( params )
-------------------------

* params

    * origin

        Number或Array。基础值。

    * numSteps

        Number。步数，或生成关键帧的数量。

    * startTime

        Number。开始摇晃的时间。

    * stepTime

        Number。每一步的时间间隔。

    * amount

        Number。摇晃效果的量。

    * interpolation

        可选。默认Interpolation.linear。

        Function( t, value1, value2 )。生成的关键帧所使用的插值函数。

    * returnCenter

        可选。默认false。

        是否在每个运动后返回origin。

* 返回

    Array。Keyframe的数组。