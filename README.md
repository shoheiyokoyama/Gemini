<p align="center">
  <img src="https://github.com/shoheiyokoyama/Assets/blob/master/Gemini/logo.png" width="500">
</p>

# Overview

<img src="https://github.com/shoheiyokoyama/Assets/blob/master/Gemini/demo-circle-rotation.gif" align="left">

## What is the `Gemini`?

`Gemini` is rich scroll based animation framework for iOS, written in Swift. You can easily use `GeminiCollectionView`, which is a subclass of `UICollectionView`.

It enables you to make multiple animation which has various and customizable properties, and moreover can create your own custom scroll animation. 

`Gemini` also provides a fluent interface based on method chaining. you can use this intuitively and simply.


```swift
collectionView.gemini
    .circleRotationAnimation()
    .radius(400)
    .rotateDirection(.clockwise)
```

# Features

![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)
[![Cocoapods](https://img.shields.io/badge/Cocoapods-compatible-brightgreen.svg)](https://img.shields.io/badge/Cocoapods-compatible-brightgreen.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)
![Swift](https://img.shields.io/badge/swift-4.2-orange.svg)
![pod](https://img.shields.io/badge/pod-v1.3.1-red.svg)

<img src="https://github.com/shoheiyokoyama/Assets/blob/master/Gemini/demo-yaw-rotation.gif" align="right">

- [x] Rich animation with scrolling
- [x] Easily usable
- [x] Highly customizable
- [x] Several types of animations and properties
- [x] Supports vertical and horizontal flow layout
- [x] Supports easing function
- [x] Supports `Swift4.2`
- [x] Fluent interfaces based on method chaining
- [x] Compatible with `Carthage`
- [x] Compatible with `CocoaPods`
- [x] Example project with lots of stock animations
- [x] And More...

# Contents
- [Animation Types and properties](#anmation-types)
- [Usage](#usage)
- [Requirements](#requirements)
- [Installation](#installation)
- [Author](#author)

# <a name="anmation-types"> Animation Types and properties

The following animation types are available. See sample code [here](https://github.com/shoheiyokoyama/Gemini/tree/master/Example/Gemini) for details.

- [Cube](#cube)
- [Circle Rotation](#circle-rotation) You can configure direction of rotation using the `CircleRotationDirection`
- [3D vector rotation](#3d-vector-rotation) Each rotation types provide multiple rotation effect
  - [Roll Rotation](#roll-rotation)
  - [Pitch Rotation](#pitch-rotation)
  - [Yaw Rotation](#yaw-rotation)
- [Scale](#scale)
- [Custom](#custom) You can create your own custom scroll animation using multiple properties, rotation, scale, translation, etc.

In addition, you can also customize the following properties for the above animation types.

- BackgroundColor
- CornerRadius
- Alpha
- [Easings](#easing-function)
- [Shadow Effect](#shadow-effect)

## <a name="cube"> Cube

<p align="center">
  <img src="https://github.com/shoheiyokoyama/Assets/blob/master/Gemini/cube-horizontal.gif">
  <img src="https://github.com/shoheiyokoyama/Assets/blob/master/Gemini/cube-vertical.gif">
</p>

It's a cube animation like Instagram.
If you would like to customize the cube animation, change `cubeDegree`. 
If `cubeDegree` is 90, it moves like a regular hexahedron.

```swift
collectionView.gemini
    .cubeAnimation()
    .cubeDegree(90)
```

## <a name="circle-rotation"> CircleRotation

<p align="center">
  <img src="https://github.com/shoheiyokoyama/Assets/blob/master/Gemini/circle-horizontal.gif">
  <img src="https://github.com/shoheiyokoyama/Assets/blob/master/Gemini/circle-vertical.gif">
</p>

An animation moves in a circle. You can change `circleRadius` and `CircleRotationDirection`.

```swift
collectionView.gemini
    .circleRotationAnimation()
    .radius(450) // The radius of the circle
    .rotateDirection(.clockwise) // Direction of rotation. 
    .itemRotationEnabled(true) // Whether the item rotates or not.
```

## <a name="3d-vector-rotation"> 3D vector rotation

Available for `Roll`, `Pitch` and `Yaw` animation. These rotation animation are designed based on 3-Dimensional vector. Figure-1 shows direction of rotation based on device.

###### ***Figure-1*** Pitch, roll, and yaw axes ######
<p align="center">
  <img src="https://github.com/shoheiyokoyama/Assets/blob/master/Gemini/attitude_rotation.png" width="350">
</p>

###### Reference: [Event Handling Guide for UIKit Apps](https://developer.apple.com/library/content/documentation/EventHandling/Conceptual/EventHandlingiPhoneOS/HandlingProcessedDeviceMotionData.html#//apple_ref/doc/uid/TP40009541-CH27-SW1)

### <a name="roll-rotation"> Roll Rotation

<p align="center">
  <img src="https://github.com/shoheiyokoyama/Assets/blob/master/Gemini/roll-horizontal.gif">
  <img src="https://github.com/shoheiyokoyama/Assets/blob/master/Gemini/roll-vertical.gif">
</p>

### <a name="pitch-rotation"> Pitch Rotation

<p align="center">
  <img src="https://github.com/shoheiyokoyama/Assets/blob/master/Gemini/pitch-horizontal.gif">
  <img src="https://github.com/shoheiyokoyama/Assets/blob/master/Gemini/pitch-vertical.gif">
</p>

### <a name="yaw-rotation"> Yaw Rotation

<p align="center">
  <img src="https://github.com/shoheiyokoyama/Assets/blob/master/Gemini/yaw-horizontal.gif">
  <img src="https://github.com/shoheiyokoyama/Assets/blob/master/Gemini/yaw-vertical.gif">
</p>


Each types of rotation animation has `RotationEffect`(e.g. `RollRotationEffect`) and degree of rotation.

Customize `RotationEffect` (`up`, `down`, `sineWave`, `reverseSineWave`) and degree of rotation.

In the case of `rollRotation`, like this:
```swift
collectionView.gemini
    .rollRotationAnimation()
    .degree(45)
    .rollEffect(.rollUp)
```

## <a name="scale"> Scale

<p align="center">
  <img src="https://github.com/shoheiyokoyama/Assets/blob/master/Gemini/scale-up.gif">
  <img src="https://github.com/shoheiyokoyama/Assets/blob/master/Gemini/scale-down.gif">
</p>

The `scaleUp` gradually increases frame size, `scaleDown` decreases.

```swift
collectionView.gemini
    .scaleAnimation()
    .scale(0.75)
    .scaleEffect(.scaleUp) // or .scaleDown
```

## <a name="custom"> Custom

<p align="center">
  <img src="https://github.com/shoheiyokoyama/Assets/blob/master/Gemini/custom1.gif">
  <img src="https://github.com/shoheiyokoyama/Assets/blob/master/Gemini/custom2.gif">
</p>

You can flexibly and easily customize scroll animation. Customize properties of `GeminiAnimation.custom` such as `scale`, `scaleEffect`, `rotationAngle`, `translation`, `easing`, `shadowEffect`, `alpha`, `cornerRadius`, `backgroundColor`, `anchorPoint`, etc.

The animation of gif is customized in the following way:

```swift
collectionView.gemini
    .customAnimation()
    .translation(y: 50)
    .rotationAngle(y: 13)
    .ease(.easeOutExpo)
    .shadowEffect(.fadeIn)
    .maxShadowAlpha(0.3)
```

Or right side of gifs is customized as follows:

```swift
collectionView.gemini
    .customAnimation()
    .backgroundColor(startColor: lightGreenColor, endColor: lightBlueColor)
    .ease(.easeOutSine)
    .cornerRadius(75)
```

There are more sample code at [CustomAnimationViewController.swift](https://github.com/shoheiyokoyama/Gemini/blob/master/Example/Gemini/ViewControllers/CustomAnimationViewController.swift).

## <a name="easing-function"> Easing function
`Gemini` supports various easing functions based on distance of scroll.

- linear
- easeInQuad
- easeOutQuad
- easeInOutQuad
- easeInCubic
- easeOutCubic
- easeInOutCubic
- easeInQuart
-  easeOutQuart
- easeInOutQuart
- easeInQuint
- easeOutQuint
- easeInOutQuint
- easeInSine
- easeOutSine
- easeInOutSine
- easeInExpo
- easeOutExpo
- easeInOutExpo
- easeInCirc
- easeOutCirc
- easeInOutCirc

## <a name="shadow-effect"> Shadow effect
Default value is `ShadowEffect.none`. Return `shadowView` in your custom class, which is a subclass of `GeminiCell`.

- fadeIn
- nextFadeIn
- previousFadeIn
- fadeOut
- none

```swift
class CustomCollectionViewCell: GeminiCell {
    @IBOutlet weak var customShadowView: UIView!
    override var shadowView: UIView? {
        return customShadowView
    }
}
```

# <a name="usage"> Usage

1. ***Use Gemini classes***

`Gemini` is designed to be easy to use. Use `GeminiCollectionView` and `GeminiCell`. These classes is subclass of `UICollectionView`, `UICollectionViewCell`.

2. ***Configure animation***

Configure animation with fluent interface based on method chaining. You can develop expressive code that enhances readability.

3. ***Call function for animation***

Finally, call `animateVisibleCells()` in `scrollViewDidScroll(_:)`

> NOTE: If you want to adapt animation immediately after view is displayed, call `animateCell(_:)` in `collectionView(_:cellForItemAt:)` and `collectionView(_:willDisplay:forItemAt:)`.


```swift
// Import Gemini
import Gemini

// Inherite GeminiCell
class CustomCell: GeminiCell {
    ...
}

// Conform to UICollectionViewDelegate and UICollectionViewDataSource
class CustomViewController: UIViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    // Inherite GeminiCollectionView
    @IBOutlet weak var collectionView: GeminiCollectionView!

    ...

    // Configure animation and properties
    func configureAnimation() {
        collectionView.gemini
            .circleRotationAnimation()
            .radius(400)
            .rotateDirection(.clockwise)
    }

    // Call animation function
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.animateVisibleCells()
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? GeminiCell {
            self.collectionView.animateCell(cell)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        self.collectionView.animateCell(cell)
        return cell
    }
```

See [Example](https://github.com/shoheiyokoyama/Gemini/tree/master/Example/Gemini), for more details.

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## <a name="requirements"> Requirements

- Xcode 10.0
- Swift 4.2

## <a name="installation"> Installation

### CocoaPods

Gemini is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Gemini"
```

### Carthage

Add the following line to your `Cartfile`:

```ruby
github "shoheiyokoyama/Gemini"
```

## <a name="author"> Author

Shohei Yokoyama

- [GitHub](https://github.com/shoheiyokoyama)
- [Facebook](https://www.facebook.com/shohei.yokoyama.96)
- [Twitter](https://twitter.com/shoheiyokoyam)
- Gmail: shohei.yok0602@gmail.com

## License

Gemini is available under the MIT license. See the [LICENSE file](https://github.com/shoheiyokoyama/Gemini/blob/master/LICENSE) for more info.
