模板
====

要求定义已执行。

* 获取Akari对象

    `var Akari = Global._get( "__akari" );`

* 导入命名空间

    `Akari.Utilities.Factory.extend( this, Akari.Utilities );` 非全局上下文获取`global`的方法`var g = ( function(){ return this; } ).apply( null );`

* 执行

    `Akari.execute( mainComp );` `mainComp`为主合成。

* 调试用停止

    `( Global._get( "__akari" ) ).stop();` 预览。

合成
====

```
Composition(
{
  // 指名大小，实际成比例缩放符合播放器
  // width : 1280,
  // height : 720,

  // startTime : 0,
  // duration : 60000,
  // layers : [ /* ...Layer... */ ],

  // 是否隐藏界外内容
  // hasBoundaries : false
})
```

主合成与一般合成在构造器上完全互换，将`Composition`改为`MainComposition`即可。

通用属性对象
============

使用处：

* Layer

    `params.properties` 对应层源DisplayObject的各项属性。

* DynamicSourceLayer

    `params.properties` 对应层源DisplayObject的各项属性。

* DynamicVectorTextLayer

    `params.properties` 对应整个文字容器DisplayObject的各项属性。
    `params.textProperties` 对应文字的内容、间距、行距等各项属性。

* Animator

    `params.bindings` 对应单个文字或行在选择器效果最大（`effectFactor === 1`）时的属性偏移量。

* RangeSelector

    `params.properties` 对应范围选择器的范围。

```
{
  // 不需要随时间变动的属性设置为值
  "propertyName1" : 810,

  // 需要随时间变动的属性设置为Function( t )，返回`t`时的值
  "propertyName2" : function( t ){ return t * 2; },

  // 关键帧动画
  "propertyName3" : KeyframesBind(
  {
    keyframes : [ /* ...Keyframe的实例们... */ ],
    mode : KeyframesBindMode.hold
  }),

  // 访问子对象属性
  "transform.matrix3D" : $.createMatrix3D( /* ... */ ),

  // Binder.Link
  "scaleX" : function( t ){ return /* ...一些非常诡异无可名状的动画表达式... */; },
  "scaleY" : Binder.Link({ name : "scaleX" }),

  "colorTriad" : [ 255, 128, 128 ],
  "transform.colorTransform" : Binder.Link(
  {
    name : "colorTriad",
    linkFunc : function( value, time )
    {
      var ct = $.createColorTransform();
      ct.color = Utils.rgb( value[ 0 ], value[ 1 ], value[ 2 ] );
      
      return ct;
    }
  })
}
```

层
==

要使用层，首先需要一个合成。

及时使层进入和退出，这样就不会浪费时间更新已退出层。

* Akari.Display.Layer

    ```
    Layer(
    {
      source : /* ...DisplayObject... */,
      inPoint : 0,
      outPoint : 60000

      // DisplayObject属性
      // properties : {}
    })
    ```

* Akari.Display.DynamicSourceLayer

    合成嵌套和逐帧动画。

    ```
    DynamicSourceLayer(
    {
      // 基本
      provider : /* ...Composition或者Animation... */,
      inPoint : 0,
      outPoint : 60000

      // DisplayObject属性
      // properties : {},

      // 变速、剪辑
      // inPointTime : 0,
      // outPointTime : 60000

      // 设置后无视inPointTime和outPointTime
      // timeRemap : function( t ){ /* ... */ }
    })
    ```

* Akari.Display.DynamicVectorTextLayer

    矢量文字。

    ```
    DynamicVectorTextLayer(
    {
      // 基本
      font : /* ...fontData... */,
      inPoint : 0,
      outPoint : 60000
      
      // DisplayObject属性
      // properties : {},

      // 文字属性。注意动画text属性需要自写插值或使用Interpolation.hold
      // textProperties : { horizontalAlign : "left", verticalAlign : "top", letterSpacing : 20, fixedWidth : false, fontSize : 200, lineHeight : 240, text : "" },

      // 逐字动画
      // animators : []
    })
    ```

* Akari.Display.Effects.TrackMatte

    层遮罩。

    ```
    TrackMatte(
    {
      layer : /* ...Layer... */,
      mask : /* ...Layer... */
    })
    ```

* Akari.Display.Effects.ForceMotionBlur

    运动模糊。

    ```
    ForceMotionBlur(
    {
      // 通常来讲，设定更多的采样数会让效果更流畅，但会让执行更慢。
      layers : Factory.replicate( Layer, 6, function() {
        return [{
          source : /* ... */,
          inPoint : 0,
          outPoint : 60000,
          properties : {}
        }];
      } )

      // 要获得自然效果，设定exposureTime为1000 / ( 帧率 * 2 )。shutterPhase决定采样的时间点范围。
      // exposureTime : 8.3333,
      // shutterPhase : -90
    })
    ```

层源
====

* Akari.Display.Shape

    创建Shape的捷径。

    ```
    function() {
      var shape = Shape();

      shape.graphics.beginFill();
      /* ... */
      shape.graphics.endFill();

      return shape;
    }()
    ```

* Akari.Display.Solid

    一定大小的纯色矩形。

    ```
    Solid(
    {
      width : 100,
      height : 100,
      color : 0xFFFFFF
    })
    ```

* Akari.Display.Checkerboard

    一定大小的棋盘格。

    ```
    Checkerboard(
    {
      width : 100,
      height : 100,

      frequencyX : 10,
      frequencyY : 10,

      color1 : 0xFFFFFF,
      color1 : 0x000000
    })
    ```

* Akari.Display.Anchor
* Akari.Display.Anchor3D

    改变锚点。

    ```
    Anchor(
    {
      source : /* ...DisplayObject... */
      // x : 50,
      // y : 50
    })

    Anchor3D(
    {
      source : /* ...DisplayObject... */
      // x : 50,
      // y : 50,
      // z : 0
    })
    ```

逐字动画
========

```
Animator(
{
  selector : RangeSelector(
  {
    // basis : "character",
    // shapingFunc : RangeShape.square,

    // 范围的开始、结束、偏移比例
    // properties : { start : 0, end : 1, offset : 0 }
  }),

  // 每个字符DisplayObject的参数偏移量。对于非单纯数值型参数，需要自定义blendingFunc才能正确执行。
  bindings : {}

  // 这个函数用于将获取的原本的属性值，与上述偏移值混合。对于数值型参数，如位置，旋转等的Animator，无需设定。
  // 其他形式的参数，请自行按照物件类型写作函数并提供。
  // blendingFunc : function( value1, value2, effectFactor ) { return value1 + value2 * effectFactor; }
})
```

Animator可以有多个，按顺序产生效果。一旦加上Animator，文字层就会每帧重新排布字符。

关键帧动画
==========

* Akari.Animation.KeyframesBindMode

    出界表现。用于KeyframesBind的mode。

    * hold 出界时保持最近的关键帧的值。
    * repeat 在出界时重复关键帧（最后一个到第二个）。
    * pingPong 在出界时往返关键帧。

* Akari.Animation.KeyframeMode

    差值表现，用于Keyframe的mode。

    * affectNext 这个关键帧和下一个之间使用此关键帧的插值函数。
    * useNext 这个关键帧和下一个之间使用下个关键帧的插值函数。
    * weightBlend 这个关键帧和下一个之间使用两者插值函数的返回值的加权平均，由这个关键帧的插值函数过渡到下一个关键帧的插值函数。

* Akari.Animation.Interpolation

    * dimension( /* ...某个Interpolation... */ )

        将某个插值函数转换成多维适用的。

    * bezier( cpS, cpD )

        产生一个二次或以上贝塞尔曲线的插值函数。注意这不是直接设定移动轨迹的曲线的插值函数。

        昂贵。二次贝塞尔曲线约比exponential慢3.5倍；三次贝塞尔曲线约比exponential慢7倍，比linear慢约20倍；四次贝塞尔曲线约比三次慢4倍。

        ```
        // 二次贝塞尔
        Akari.Animation.Interpolation.bezier( [ 0.5 ], [ 0.9 ] );

        // 三次贝塞尔
        Akari.Animation.Interpolation.bezier( [ 0.2, 0.8 ], [ 0.8, 0.9 ] );

        // 四次贝塞尔（类推）
        Akari.Animation.Interpolation.bezier( [ 0.2, 0.5, 0.8 ], [ 0.8, -1.0, 0.9 ] );
        ```

    * hold

        保持原值。

    * linear

        线性插值。

    * cubic
    * quartic
    * quintic
    * exponential
    * back

        * easeIn

            缓入变体。

        * easeOut

            缓出变体。

        * easeInOut

            缓入且缓出变体。

        * easeOutIn

            逆缓入且逆缓出变体。

* Akari.Animation.WiggleKeyframes

    产生摇晃的一系列关键帧。

    ```
    KeyframesBind(
    {
      keyframes : WiggleKeyframes(
      {
        origin : 0,
        numSteps : 10,
        startTime : 0,
        stepTime : 100,
        amount : 50

        // interpolation : Interpolation.linear,
        // returnCenter : false
      }),
      mode : KeyframesBindMode.repeat
    })
    ```

    位置摇晃示例，原点[ 640, 360 ], 量100，每秒一动，持续一分钟。

    ```
    {
      "pos" : KeyframesBind(
      {
        keyframes : WiggleKeyframes(
        {
          origin : [ 640, 360 ],
          numSteps : 60,
          startTime : 0,
          stepTime : 1000,
          amount : 100,

          interpolation : Interpolation.cubic.easeInOut,
          returnCenter : false
        }),
        mode : KeyframesBindMode.repeat
      }),

      "x" : Binder.Link(
      {
        name : "pos",
        linkFunc : function( v ) { return v[ 0 ]; }
      }),

      "y" : Binder.Link(
      {
        name : "pos",
        linkFunc : function( v ) { return v[ 1 ]; }
      })
    }
    ```

表达式上下文
============

对于Layer和其所有子类的`params.properties`中的函数，`this`是对Layer本身的引用。可以通过this访问到以下属性。

* this.source

    DisplayObject。Layer的层源。

* this.inPoint

    Number。Layer进入时间。

* this.outPoint

    Number。Layer退出时间。

* this.parent

    Composition。包含这个层的合成或null。通过父合成还可以访问到所有其他层的这些属性。

一些Layer的子类可能含有额外的可访问属性。