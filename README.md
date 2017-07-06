![Bamboo](https://raw.githubusercontent.com/wordlessj/Bamboo/master/Assets/Logo.png)

<br>

[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](#carthage)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Bamboo.svg)](#cocoapods)
[![Platform](https://img.shields.io/cocoapods/p/Bamboo.svg?style=flat)](#installation)
[![Build Status](https://travis-ci.org/wordlessj/Bamboo.svg)](https://travis-ci.org/wordlessj/Bamboo)

Bamboo makes Auto Layout (and manual layout) elegant and concise.

## Quick Look

```swift
view.constrain.centerX().below(view2).size(100)
```

It’s equivalent to iOS 9 API:

```swift
view.centerXAnchor.constraint(equalTo: view.superview!.centerXAnchor)
view.topAnchor.constraint(equalTo: view2.bottomAnchor)
view.widthAnchor.constraint(equalToConstant: 100)
view.heightAnchor.constraint(equalToConstant: 100)
```

As you can see, Bamboo eliminated a lot of redundant code.

- Using chaining style, you can write view’s name just once.
- All methods are grouped in `constrain` extension, so their names can be simple and short.
- Superview and anchor are usually implied.
- More higher level methods like `below()` and `size()` make things easier.

## Installation

Bamboo supports iOS 9.0+, macOS 10.11+ and tvOS 9.0+, it’s compatible with Swift 3.

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
view.constrain.left()

// Or use it on UILayoutGuide.
layoutGuide.constrain.left()
```

To specify another view’s corresponding anchor, simply pass the view to the method.

```swift
// view1.left == view2.left
view1.constrain.left(view2)
```

Of course, you can use a specific anchor.

```swift
// view1.left == view2.right
view1.constrain.left(view2.rightAnchor)
```

Including a constant is straightforward using operator `+` or `-`.

```swift
// view1.left == view2.right + 10
view1.constrain.left(view2.rightAnchor + 10)

// Specific view or anchor can be omitted.
// view.left == superview.left + 10
view.constrain.left(10)
```

For dimension anchors, when only a constant is specified, it sets the dimension to the constant, instead of matching to superview.

```swift
// view.width == 10
view.constrain.width(10)
```

> `width()` and `width(0)` are different, the former match to superview and the latter set to 0.

Similarly, use `>=` or `<=` to specify equality.

```swift
// view1.left >= view2.right + 10
view1.constrain.left(>=view2.rightAnchor + 10)
```

To specify priority, use operator `~`.

```swift
// view1.left == view2.right + 10 (priority 500)
view1.constrain.left(view2.rightAnchor + 10 ~ 500)
```

For dimension anchors, multiplier can be specified with `*` or `/`.

```swift
// view1.width == 2 * view2.width
view1.constrain.width(2 * view2)
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
let c: NSLayoutConstraint = view.constrain.left().constraint
```

Or get all constraints accumulated from the chain.

```swift
let c: [NSLayoutConstraint] = view.constrain.left().top().constraints
```

### Activate and Deactivate

Constraints can be activated and deactivated easily so you can better control the layout change.

```swift
// Deactivate after creation.
let c: [NSLayoutConstraint] = view.constrain.left().top().constraints.deactivate()

// Activate later when appropriate.
c.activate()
```

### Higher Level Methods

#### Aspect Ratio

```swift
// view.width == 2 * view.height
view.constrain.aspectRatio(2)
```

#### Center and Size

Both methods are similar to basic anchor methods.

```swift
center() // centerX and centerY
size()   // width and height
```

There are two more methods to set size.

```swift
let cgSize: CGSize
view.constrain.size(cgSize)

view.constrain.size(width: 10, height: 20)
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
view1.constrain.fill(view2, insets: insets)

// If all edge insets are the same, you can pass a single value.
// view1 fills view2 with insets 10.
view1.constrain.fill(view2, insets: 10)
```

#### Around

```swift
before()
after()
above()
below()
```

These methods take two optional arguments like fill methods, except the second one is spacing.

```swift
// view1.right == view2.left - 10
view1.constrain.before(view2, spacing: 10)
```

### Multiple Items

You can constrain on multiple items at once. There are two fundamental methods on which other methods are built.

```swift
// Constrain on each item.
// e.g., Set each item's width to 10.
[view1, view2, view3].constrain.each {
    $0.constrain.width(10)
}

// Constrain between every two items.
// e.g., view1.left == view2.left, view2.left == view3.left
[view1, view2, view3].constrain.between {
    $0.constrain.left($1)
}
```

Most basic methods on single item are available on multiple items.

```swift
// Anchor methods take no arguments and align all items' corresponding anchor.
// e.g., Align all views' left.
[view1, view2, view3].constrain.left()

// For dimension anchors, you can set values for all items.
// e.g., Set all views' width to 10.
[view1, view2, view3].constrain.width(10)
```

You can distribute items on an axis.

```swift
distributeHorizontally()
distributeVertically()

// [view1]-10-[view2]-10-[view3]
[view1, view2, view3].constrain.distributeHorizontally(spacing: 10)
```

## Manual Layout

Why manual layout when there is Auto Layout? Well, Auto Layout is good, but it has some performance issues, that’s when you may want to switch to manual layout.

[Manual Layout Guide](https://github.com/wordlessj/Bamboo/blob/master/Documentation/Manual%20Layout%20Guide.md)

## License

Bamboo is released under the MIT license. See LICENSE for details.
