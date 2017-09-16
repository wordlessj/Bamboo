![Bamboo](https://raw.githubusercontent.com/wordlessj/Bamboo/master/Assets/Logo.png)

<br>

[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](#carthage)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Bamboo.svg)](#cocoapods)
![Swift 4](https://img.shields.io/badge/Swift-4-orange.svg)
![Platform](https://img.shields.io/badge/platform-iOS%209.0%2B%20%7C%20macOS%2010.11%2B%20%7C%20tvOS%209.0%2B-lightgrey.svg)
[![Build Status](https://travis-ci.org/wordlessj/Bamboo.svg?branch=master)](https://travis-ci.org/wordlessj/Bamboo)

Auto Layout (and manual layout) in one line.

## Quick Look

```swift
view.bb.centerX().below(view2).size(100)
```

It’s equivalent to iOS 9 API:

```swift
view.centerXAnchor.constraint(equalTo: view.superview!.centerXAnchor).isActive = true
view.topAnchor.constraint(equalTo: view2.bottomAnchor).isActive = true
view.widthAnchor.constraint(equalToConstant: 100).isActive = true
view.heightAnchor.constraint(equalToConstant: 100).isActive = true
```

As you can see, Bamboo eliminated a lot of redundant code.

- Using chaining style, you can write view’s name just once.
- All methods are grouped in `bb` extension, so their names can be simple and short.
- Superview and anchor are usually implied.
- More higher level methods like `below()` and `size()` make things easier.

## Installation

### Carthage

```
github "wordlessj/Bamboo" ~> 1.0
```

### CocoaPods

```
pod 'Bamboo', '~> 1.0'
```

## Usage

### Basics

All basic anchors on `UIView` and `UILayoutGuide` are provided with suffix `Anchor` stripped, e.g., `left` instead of `leftAnchor`.

```swift
// view.left == superview.left
view.bb.left()

// Or use it on UILayoutGuide.
layoutGuide.bb.left()
```

To specify another view’s corresponding anchor, simply pass the view to the method.

```swift
// view1.left == view2.left
view1.bb.left(view2)
```

Of course, you can use a specific anchor.

```swift
// view1.left == view2.right
view1.bb.left(view2.rightAnchor)
```

Including a constant is straightforward using operator `+` or `-`.

```swift
// view1.left == view2.right + 10
view1.bb.left(view2.rightAnchor + 10)

// Specific view or anchor can be omitted.
// view.left == superview.left + 10
view.bb.left(10)
```

For dimension anchors, when only a constant is specified, it sets the dimension to the constant, instead of matching to superview.

```swift
// view.width == 10
view.bb.width(10)
```

> `width()` and `width(0)` are different, the former match to superview and the latter set to 0.

In iOS 11, you can use `SystemSpacing` in place of constant, pass multiplier to the initializer, only `+` operator is supported.

```swift
// view1.left == view2.right + 2 * SystemSpacing
view1.bb.left(view2.rightAnchor + SystemSpacing(2))
```

Similarly, use `>=` or `<=` to specify equality.

```swift
// view1.left >= view2.right + 10
view1.bb.left(>=view2.rightAnchor + 10)
```

To specify priority, use operator `~`.

```swift
// view1.left == view2.right + 10 (priority 500)
view1.bb.left(view2.rightAnchor + 10 ~ 500)
```

For dimension anchors, multiplier can be specified with `*` or `/`.

```swift
// view1.width == 2 * view2.width
view1.bb.width(2 * view2)
```

### Expression

Expressions are passed to basic anchor methods. Full form:

```
( >= or <= ) item + constant ~ priority
```

For dimension anchors:

```
( >= or <= ) item * multiplier + constant ~ priority
```

`item` can be `UIView`, `UILayoutGuide` or `NSLayoutAnchor`. You can use `/` and `-` instead of `*` and `+`. If equality is not specified, `multiplier` can be put before `item` to be more like linear functions. More complex expressions can be created, but for simplicity, it’s not recommended.

### Constraints

You can get a single constraint created from the method for later use.

```swift
let c: NSLayoutConstraint = view.bb.left().constraint
```

Or get all constraints accumulated from the chain.

```swift
let c: [NSLayoutConstraint] = view.bb.left().top().constraints
```

### Activate and Deactivate

Constraints can be activated and deactivated easily so you can better control the layout change.

```swift
// Deactivate after creation.
let c: [NSLayoutConstraint] = view.bb.left().top().constraints.deactivate()

// Activate later when appropriate.
c.activate()
```

### Higher Level Methods

#### Aspect Ratio

```swift
// view.width == 2 * view.height
view.bb.aspectRatio(2)
```

#### Center and Size

Both methods are similar to basic anchor methods.

- `center()`, consists of `centerX` and `centerY`.
- `size()`, consists of `width` and `height`.

There are two more methods to set size.

```swift
let cgSize: CGSize
view.bb.size(cgSize)

view.bb.size(width: 10, height: 20)
```

#### Fill

```swift
// Pin all edges.
fill()

// Pin corresponding edge and adjacent edges.
// e.g., fillLeft() pin left, top and bottom.
fill[Left|Right|Top|Bottom|Leading|Trailing]()

// Pin edges on corresponding axis.
// e.g., fillWidth() pin leading and trailing.
fill[Width|Height]()
```

All fill methods take two optional arguments, first is either `UIView` or `UILayoutGuide` to be filled, `nil` for its superview, second is a `UIEdgeInsets`.

```swift
// view1 fills view2 with insets.
let insets: UIEdgeInsets
view1.bb.fill(view2, insets: insets)

// If all edge insets are the same, you can pass a single value.
// view1 fills view2 with insets 10.
view1.bb.fill(view2, insets: 10)
```

#### Around

- `before()`
- `after()`
- `above()`
- `below()`

These methods take two optional arguments like fill methods, except the second one is spacing.

```swift
// view1.trailing == view2.leading - 10
view1.bb.before(view2, spacing: 10)
```

#### Offset

In iOS 10, use `-` operator to create an offset anchor between two axis anchors, then use `offset()` to create a constraint. It does not matter which view is used before `bb`.

```swift
// view2.left - view1.right == view3.left - view2.right
view1.bb.offset(view2.leftAnchor - view1.rightAnchor, view3.leftAnchor - view2.rightAnchor)
```

### Multiple Items

You can constrain on multiple items at once. There are two fundamental methods on which other methods are built.

```swift
// Constrain on each item.
// e.g., Set each item's width to 10.
[view1, view2, view3].bb.each {
    $0.bb.width(10)
}

// Constrain between every two items.
// e.g., view1.left == view2.left, view2.left == view3.left
[view1, view2, view3].bb.between {
    $0.bb.left($1)
}
```

Most basic methods on single item are available on multiple items.

```swift
// Anchor methods take no arguments and align all items' corresponding anchor.
// e.g., Align all views' left.
[view1, view2, view3].bb.left()

// For dimension anchors, you can set values for all items.
// e.g., Set all views' width to 10.
[view1, view2, view3].bb.width(10)
```

You can distribute items along an axis with fixed spacing or equal spacing.

- `distributeX()`
- `distributeY()`
- `distributeXEqualSpacing()`
- `distributeYEqualSpacing()`

```swift
// [view1]-10-[view2]-10-[view3]
[view1, view2, view3].bb.distributeX(spacing: 10)
```

All `distribute` methods come with an optional `inset` parameter, you can specify no insets, fixed insets or equal insets.

```swift
// |-[view1]-[view2]-[view3]-|, spacings are all equal.
[view1, view2, view3].bb.distributeXEqualSpacing(inset: .equal)
```

## Manual Layout

Why manual layout when there is Auto Layout? Well, Auto Layout is good, but it has some performance issues, that’s when you may want to switch to manual layout.

[Manual Layout Guide](https://github.com/wordlessj/Bamboo/blob/master/Documentation/Manual%20Layout%20Guide.md)

## Panda

[Panda](https://github.com/wordlessj/Panda) is a framework which creates view hierarchies declaratively, together with Bamboo, they make creating views in code incredibly simple and easy.

## License

Bamboo is released under the MIT license. See LICENSE for details.
