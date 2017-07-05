# Manual Layout Guide

Manual layout in Bamboo looks very similar to Auto Layout, but under the hood they are totally different. There is one important rule to follow:

**Set size before setting position.**

Because size changes relative to center, it may change the relative position set before, so remember to set size first.

## Basics

There are some additional properties on `UIView` and `CALayer` to better describe layout.

```swift
var size: CGSize
var left: CGFloat
var right: CGFloat
var top: CGFloat
var bottom: CGFloat
```

These properties and `center` are available as set methods.

```swift
// Set view1's left to view2's right.
view1.layout.left(view2.right)
```

## Super

When layout to superview, you can’t use superview’s layout properties directly, because they are in different coordinates. Instead, use `super*` properties on `layout`.

```swift
var superSize: CGSize
var superCenter: CGPoint
var superLeft: CGFloat
var superRight: CGFloat
var superTop: CGFloat
var superBottom: CGFloat

// Set view's right to superview's right inset by 10.
view.layout.right(view.layout.superRight - 10)

// Convenience method.
view.layout.right(inset: 10)
```

## Fill

You have to specify the remaining dimension when using fill methods.

```swift
fill()
fill[Left|Right](width:)
fill[Top|Bottom](height:)
fill[Width|Height]()
```

## Around

They are almost the same with that in Auto Layout.

```swift
before()
after()
above()
below()
```

## Fit

Fit methods use `sizeThatFits()` to set corresponding value.

```swift
fitSize()
fitWidth()
fitHeight()
```
