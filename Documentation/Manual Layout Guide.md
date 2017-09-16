# Manual Layout Guide

Manual layout in Bamboo looks very similar to Auto Layout, but under the hood they are totally different. There is one important rule to follow:

**Set size before setting position.**

Because size changes relative to center, it may change the relative position set before, so remember to set size first.

## Basics

There are some additional properties on `UIView` and `CALayer` to better describe layout.

- `size`
- `left`
- `right`
- `top`
- `bottom`

These properties and `center` are available as set methods.

```swift
// Set view1's left to view2's right.
view1.bbm.left(view2.right)
```

## Super

When layout to superview, you can’t use superview’s layout properties directly, because they are in different coordinates. Instead, use `super*` properties on `bbm`.

- `superSize`
- `superCenter`
- `superLeft`
- `superRight`
- `superTop`
- `superBottom`

```swift
// Set view's right to superview's right inset by 10.
view.bbm.right(view.bbm.superRight - 10)

// Convenience method.
view.bbm.right(inset: 10)
```

## Fill

You have to specify the remaining dimension when using fill methods.

- `fill()`
- `fill[Left|Right](width:)`
- `fill[Top|Bottom](height:)`
- `fill[Width|Height]()`

## Around

They are almost the same with that in Auto Layout.

- `before()`
- `after()`
- `above()`
- `below()`

## Fit

Fit methods use `sizeThatFits()` to set corresponding value.

- `fitSize()`
- `fitWidth()`
- `fitHeight()`
