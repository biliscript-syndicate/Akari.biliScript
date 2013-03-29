Akari.Display.Text.DynamicVectorTextLayer
=========================================

类。继承Akari.Display.Layer。

用于显示矢量文字的层。由于显示效果的原因，建议使用这种层来显示文字，而避免使用TextField。因此，Text类不在这一版本的参考中出现。

DynamicVectorTextLayer( params )
--------------------------------

* params

    * dictionary

        可选。默认null。在没有设置font时，必须设置dictionary。

        Object。绘制单个字符的Function( graphics )的关联数组。字符应该由用户提供，并且在左上角锚定。

        不推荐使用。请尽量使用font属性。

    * font

        可选。默认null。

        Object。Xarple的VectorFont2Biliscript所生成的形式的字体对象。

        当设置了font时，将无视dictionary设定。同时，letterSpacing和lineHeight的默认值将变为0。

    * inPoint

        Number。层的进入点（毫秒）。

    * outPoint

        Number。层的退出点（毫秒）。

    * textProperties

        可选。默认{ horizontalAlign : "left", verticalAlign : "top", letterSpacing : 20, fixedWidth : false, fontSize : 200, lineHeight : 240, text : "" }。

        Object。用于文字的属性对象。

        * horizontalAlign

            String。水平对齐方式。可选"left"、"center"、"right"。

        * verticalAlign

            String。垂直对齐方式。可选"top"、"center"、"bottom"。

        * fontSize

            Number。目标字体大小。

        * letterSpacing

            Number。字间的基准距离。当采用font时，这是字间额外的距离。

        * fixedWidth

            Boolean。是否视作等宽字体。如设定为true将强制等宽，并无视kerning。若为false且无kerning，则将采用测量自动kerning。

        * lineHeight

            Number。行高，这一数值应包括字体高度。当采用font时，设置这项属性将覆盖字体自带的行高设定。

        * text

            String。要显示的文字串。

    * properties

        可选。默认为{}。

        Object。用于容器的属性对象。

    * animators

        可选。默认为[]。

        Array。包含要使用的Animator。

* 返回

    DynamicVectorTextLayer。

Akari.Display.Text.Selector
===========================

接口。

用于Animator的选择器都应该实现此接口。由于JavaScript特性，这个接口没有也不必在代码中定义。

Selector#select( time, linesContainer, callback )
-------------------------------------------------

* 参数

    * time

        Number。当前时间。

    * linesContainer

        Sprite。目标的容器。

    * callback

        Function( object, effectFactor )。

        * 参数

            * object

                DisplayObject。目标对象。

            * effectFactor

                Number。结果的效果指示数。

Akari.Display.Text.RangeShape
=============================

枚举。

Function( proportion )。被RangeSelector使用。

square
------

方形范围。

triangle
--------

三角形范围。

rampUp
------

上坡范围。

rampDown
--------

下坡范围。

Akari.Display.Text.RangeSelector
================================

类。实现Selector。

按照范围和文字位置的选择器的统一化类。

RangeSelector( params )
-----------------------

* params

    * basis

        可选。默认"characters"。

        String。选择的基准。可选"characters"、"lines"。

    * shapingFunc

        可选。默认RangeShape.square。

        Function( proportion )。决定选区的形状。

        * 参数

            * proportion

                Number。对象在容器中的比例位置。0~1。

        * 返回

            Number。effectFactor。

    * properties

        可选。默认{ start : 0, end : 1, offset : 0 }。

        Object。属性对象。单位全部为比例。

        * start

            Number。范围开始的位置。

        * end

            Number。范围结束的位置。

        * offset

            Number。范围的偏移量。

Akari.Display.Text.Animator
===========================

类。

被DynamicVectorTextLayer用作逐字动画。

Animator( params )
------------------

* params

    * selector

        Selector。用于选择要改变属性的文字。

    * bindings

        Object。偏移属性对象。

    * blendingFunc

        可选。默认为function( value1, value2, effectFactor ) { return value1 + value2 * effectFactor; }。

        Function( value1, value2, effectFactor )。

        * 参数

            * value1

                Object。属性原本的值。

            * value2

                Object。属性的偏移值。

            * effectFactor

                Number。0~1，指示偏移的强度。

        * 返回

            Object。偏移后的值。

* 返回

    Animator。

Animator#apply( time, linesContainer )
--------------------------------------

应用Animator效果。

* 参数

    * time

        Number。当前时间。

    * linesContainer

        Sprite。目标的容器。