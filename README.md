#FLCorner

![](https://img.shields.io/badge/build-passing-brightgreen.svg)
![](https://img.shields.io/badge/pod-v0.0.1-blue.svg)
![](https://img.shields.io/badge/language-objc-5787e5.svg)
![](https://img.shields.io/badge/license-MIT-brightgreen.svg)  

This library provides a category for UIImageView with an effective way to add rounded corners
高效添加图片圆角

-  CoreGraphics绘制图片，解决了图片离屏渲染卡顿问题
-  提供多种快速添加圆角的方式


##CocoaPods:
```
pod 'FLCorner'
```

## usage:
```
// 方式1 圆角+边框(默认黑色)
[imageView fl_imageViewWithCorner:50.f];
// 方式2 圆角+边框(默认黑色)
[imageView fl_imageViewWithCorner:50.f borderWidth:10.f];
//  方式3 圆角+自定义边框颜色
[imageV4 fl_imageViewWithCorner:50.f borderWidth:10.f borderColor:[UIColor redColor]];
// 方式4 圆角+自定义边框颜色+圆角样式
[imageV5 fl_imageViewWithCorner:50.f borderWidth:10.
```
##License:  

FLCorner is released under the MIT license. See LICENSE for details.


