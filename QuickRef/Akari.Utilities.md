Akari.Utilities.Factory
=======================

静态类。

提供创建和操纵对象的方法。因为历史原因使用此命名（参见：2012/11/21更新）

collapse( arrays )
------------------

将给出的所有数组连接为一个。目前的情况下，Composition会在layers参数上调用一次collapse，因此可以在写作合成时，没有顾虑地混编层和层数组。

* 参数

    * arrays

        Array。需要连接的数组的数组。

* 返回

    Array。

extend( destination, source )
-----------------------------

将所有属性从source复制到destination对象。请注意destination会被直接修改。如不希望被修改请事先复制。可用于导入命名空间。用法是在全局命名空间下调用Factory.extend( this, Some.Namespace )。

* 参数

    * destination

        Object。目标对象。

    * source

        Object。源对象。

* 返回

    Object。destionation。

clone( object, scope )
----------------------

深复制一个对象。

* 参数

    * object

        Object。要复制的对象。

    * scope

        Object。要复制的对象为Function时的this。迭代时使用。

* 返回

    Object。复制结果。

replicate( constructor, count, paramsFunction )
-----------------------------------------------

返回一组根据给出的参数创建的对象。既可以用于ForceMotionBlur效果层，亦可活用于创建类似于粒子系统的效果。需要注意的是如果通过replicate生成了过多层，性能可能会有所下降。

如果一个现有的构造器呼叫：

```
Class({
  someParam : 1,
  someOtherParam : 2
});
```

要被应用replicate，可以将其简易地改造为：

```
Factory.replicate( Class, 12, function( i ) {
    return [{
      someParam : 1,
      someOtherParam : 2 // i * 2
    }];
} );
```

* 参数

    * constructor

        Function。构造器。

    * count

        Number。数目。

    * paramsFunction

        可选。如无则以无参数创建对象。

        Function( index )。

        * 参数

            * index

                Number。正在创建的对象的索引。从0开始。

        * 返回

            Array。构造器参数的数组。

* 返回

    Array。创建的对象的数组。

Akari.Utilities.Binder
======================

类。

提供绑定属性值功能，主要在Layer中使用。

Akari.Utilities.Binder( params )
--------------------------------

* params

    * object

        Object。目标对象。

    * properties

        Object。属性对象。

    * overridePathCheck

        可选。默认值false。

        Boolean。设定这个值将会取消路径检查，这样就可以向目标对象添加新属性。因为对AS3对象无法添加属性(Error #1056)，所以加入了路径检查的保护机制。请仅在需要功能时打开。

* 返回

    Binder。

Binder#update( time, scope )
----------------------------

更新目标对象以与时间轴相合。

* 参数

    * time

        Number。时间轴上的当前时间（毫秒）。

    * scope

        可选。默认同目标对象。

        Object。执行函数的上下文对象。

Akari.Utilities.Binder.Link
===========================

类。

表示不同属性间的一个链接。当一个属性由多个步骤产生时，可以暂将中间值设定到一个不存在的属性名上，然后再用Binder.Link来获取中间值。这避免了使用函数封套属性（仅仅是难看），或更糟糕的，在每帧上呼叫关键帧之类的构造器。例子可见Animating Sample。

Akari.Utilities.Binder.Link( params )
-------------------------------------

* params

    * name

        String。要连接的属性的名字。

    * linkFunc

        可选。默认为null。

        Function( value, time )。

        * 参数

            * value

                Object。被链接属性的值。

            * time

                Number。当前时间。

        * 返回

            Object。当属性的新值。

* 返回

    Binder.Link。

Akari.Utilities.Binder.Sequence
===============================

类。

表示不同属性间的一个序列。

Akari.Utilities.Binder.Sequence( params )
-----------------------------------------

* params

    * sequence

        Array。前置属性的名/值对的数组。

    * value

        Object。当属性的值。    

* 返回

    Binder.Sequence。

Akari.Utilities.Timer
=====================

静态类。

通过采样每帧的时间使用提供比Player.time更加精准的时间，目的是在保证可跳转性的同时提高流畅度。

time
----

Number。当前时间。以毫秒为单位。

update()
--------

计入一帧并更新时间。