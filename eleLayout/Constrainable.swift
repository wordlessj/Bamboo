//
//  Constrainable.swift
//  eleLayout
//
//  Created by Javier on 8/22/16.
//  Copyright © 2016 Javier. All rights reserved.
//

#if os(iOS)
    import UIKit
#else
    import AppKit
#endif

public struct ItemConstraint<Item: AnyObject>: Constrainable {
    public var constrainableItem: Item
    public var constraint: NSLayoutConstraint
    public var allConstraints: [NSLayoutConstraint]
}

public struct ItemConstraints<Item: AnyObject>: Constrainable {
    public var constrainableItem: Item
    public var constraints: [NSLayoutConstraint]
    public var allConstraints: [NSLayoutConstraint]
}

public protocol Constrainable {
    associatedtype Item: AnyObject
    var constrainableItem: Item { get }
    var allConstraints: [NSLayoutConstraint] { get }
}

extension Constrainable {
    public func constrainToPin<C: Constrainable>(
        to attribute: NSLayoutAttribute,
        of constrainable: C,
        offset: CGFloat = 0,
        relation: NSLayoutRelation = .Equal
    ) -> ItemConstraint<Item> {
        return constrain(attribute.flipped, to: attribute, of: constrainable.constrainableItem,
                         offset: offset, relation: relation)
    }

    public func constrainSize(size: CGSize) -> ItemConstraints<Item> {
        return itemConstraints(with: [constrainSize(.Width, to: size.width), constrainSize(.Height, to: size.height)])
    }

    public func constrainSize(attribute: NSLayoutAttribute, to size: CGFloat,
                              relation: NSLayoutRelation = .Equal) -> ItemConstraint<Item> {
        return constrain(attribute, to: .NotAnAttribute, of: nil, multiplier: 0, offset: size, relation: relation)
    }

    public func constrainSize<C: Constrainable>(to constrainable: C) -> ItemConstraints<Item> {
        return constrain(to: [.Width, .Height], of: constrainable)
    }

    public func constrain<C: Constrainable>(to attributes: [NSLayoutAttribute],
                                            of constrainable: C) -> ItemConstraints<Item> {
        return itemConstraints(with: attributes.map { constrain(to: $0, of: constrainable) })
    }

    public func constrain<C: Constrainable>(
        to attribute: NSLayoutAttribute,
        of constrainable: C,
        multiplier: CGFloat = 1,
        offset: CGFloat = 0,
        relation: NSLayoutRelation = .Equal
    ) -> ItemConstraint<Item> {
        return constrain(attribute, to: attribute, of: constrainable.constrainableItem,
                         multiplier: multiplier, offset: offset, relation: relation)
    }

    public func constrain(
        attribute: NSLayoutAttribute,
        to toAttribute: NSLayoutAttribute,
        of item: AnyObject?,
        multiplier: CGFloat = 1,
        offset: CGFloat = 0,
        relation: NSLayoutRelation = .Equal
    ) -> ItemConstraint<Item> {
        if let view = self as? View { view.translatesAutoresizingMaskIntoConstraints = false }
        let constraint = NSLayoutConstraint(item: constrainableItem, attribute: attribute, relatedBy: relation,
                                            toItem: item, attribute: toAttribute,
                                            multiplier: multiplier, constant: offset)
        constraint.active = true
        return ItemConstraint(constrainableItem: constrainableItem,
                              constraint: constraint,
                              allConstraints: allConstraints + [constraint])
    }

    func itemConstraints(with array: [ItemConstraint<Item>]) -> ItemConstraints<Item> {
        let constraints = array.map { $0.constraint }
        return ItemConstraints(constrainableItem: constrainableItem,
                               constraints: constraints,
                               allConstraints: allConstraints + constraints)
    }
}

extension Constrainable where Item: View {
    public func constrainToFillSuperview(
        attribute: NSLayoutAttribute? = nil,
        insets: EdgeInsets = EdgeInsets()
    ) -> ItemConstraints<Item> {
        var constraints = [ItemConstraint<Item>]()

        if attribute != .Left && attribute != .Leading && attribute != .Height {
            constraints.append(constrainToSuperview(.Trailing, offset: -insets.right))
        }
        if attribute != .Right && attribute != .Trailing && attribute != .Height {
            constraints.append(constrainToSuperview(.Leading, offset: insets.left))
        }
        if attribute != .Top && attribute != .Width {
            constraints.append(constrainToSuperview(.Bottom, offset: -insets.bottom))
        }
        if attribute != .Bottom && attribute != .Width {
            constraints.append(constrainToSuperview(.Top, offset: insets.top))
        }

        return itemConstraints(with: constraints)
    }

    public func constrainToPosition(attribute: NSLayoutAttribute, toSuperviewPercent percent: CGFloat,
                                    offset: CGFloat = 0, relation: NSLayoutRelation = .Equal) -> ItemConstraint<Item> {
        let toAttribute: NSLayoutAttribute

        switch attribute {
        case .Left, .Right, .Leading, .Trailing, .CenterX: toAttribute = .Right
        case .Top, .Bottom, .CenterY: toAttribute = .Bottom
        default: toAttribute = attribute
        }

        return constrain(attribute, toSuperview: toAttribute, multiplier: percent, offset: offset, relation: relation)
    }

    public func constrainCenterToSuperview() -> ItemConstraints<Item> {
        return constrainToSuperview([.CenterX, .CenterY])
    }

    public func constrainSizeToSuperview() -> ItemConstraints<Item> {
        return constrainToSuperview([.Width, .Height])
    }

    public func constrainToSuperview(attributes: [NSLayoutAttribute]) -> ItemConstraints<Item> {
        return itemConstraints(with: attributes.map { constrainToSuperview($0) })
    }

    public func constrainToSuperview(
        attribute: NSLayoutAttribute,
        multiplier: CGFloat = 1,
        offset: CGFloat = 0,
        relation: NSLayoutRelation = .Equal
    ) -> ItemConstraint<Item> {
        return constrain(attribute.removingMargin, toSuperview: attribute,
                         multiplier: multiplier, offset: offset, relation: relation)
    }

    public func constrain(
        attribute: NSLayoutAttribute,
        toSuperview toAttribute: NSLayoutAttribute,
        multiplier: CGFloat = 1,
        offset: CGFloat = 0,
        relation: NSLayoutRelation = .Equal
    ) -> ItemConstraint<Item> {
        return constrain(attribute, to: toAttribute, of: constrainableItem.superview,
                         multiplier: multiplier, offset: offset, relation: relation)
    }
}

extension View: Constrainable {
    public var constrainableItem: View { return self }
    public var allConstraints: [NSLayoutConstraint] { return [] }
}

#if os(iOS)
    extension Constrainable {
        public func constrainToPinToTopLayoutGuide(
            of viewController: UIViewController,
            inset: CGFloat = 0,
            relation: NSLayoutRelation = .Equal
        ) -> ItemConstraint<Item> {
            return constrain(.Top, to: .Bottom, of: viewController.topLayoutGuide, offset: inset, relation: relation)
        }

        public func constrainToPinToBottomLayoutGuide(
            of viewController: UIViewController,
            inset: CGFloat = 0,
            relation: NSLayoutRelation = .Equal
        ) -> ItemConstraint<Item> {
            return constrain(.Bottom, to: .Top, of: viewController.bottomLayoutGuide,
                             offset: -inset, relation: relation.reversed)
        }
    }

    extension Constrainable where Item: View {
        public func constrainToFillSuperviewMargins(attribute: NSLayoutAttribute? = nil) -> ItemConstraints<Item> {
            var constraints = [ItemConstraint<Item>]()

            if attribute != .LeftMargin && attribute != .LeadingMargin && attribute != .Height {
                constraints.append(constrainToSuperview(.TrailingMargin))
            }
            if attribute != .RightMargin && attribute != .TrailingMargin && attribute != .Height {
                constraints.append(constrainToSuperview(.LeadingMargin))
            }
            if attribute != .TopMargin && attribute != .Width {
                constraints.append(constrainToSuperview(.BottomMargin))
            }
            if attribute != .BottomMargin && attribute != .Width {
                constraints.append(constrainToSuperview(.TopMargin))
            }
            
            return itemConstraints(with: constraints)
        }

        public func constrainCenterToSuperviewMargins() -> ItemConstraints<Item> {
            return constrainToSuperview([.CenterXWithinMargins, .CenterYWithinMargins])
        }
    }

    @available(iOS 9.0, *)
    extension UILayoutGuide: Constrainable {
        public var constrainableItem: UILayoutGuide { return self }
        public var allConstraints: [NSLayoutConstraint] { return [] }
    }
#endif
