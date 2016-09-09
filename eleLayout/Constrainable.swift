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
    associatedtype ConstrainableItem: AnyObject
    var constrainableItem: ConstrainableItem { get }
    var allConstraints: [NSLayoutConstraint] { get }
}

extension Constrainable {
    @discardableResult
    public func constrainToPin<C: Constrainable>(
        to attribute: NSLayoutAttribute,
        of constrainable: C,
        offset: CGFloat = 0,
        relation: NSLayoutRelation = .equal
    ) -> ItemConstraint<ConstrainableItem> {
        return constrain(attribute.flipped, to: attribute, of: constrainable.constrainableItem,
                         offset: offset, relation: relation)
    }

    @discardableResult
    public func constrainSize(_ size: CGSize) -> ItemConstraints<ConstrainableItem> {
        return itemConstraints(with: [constrainSize(.width, to: size.width), constrainSize(.height, to: size.height)])
    }

    @discardableResult
    public func constrainSize(_ attribute: NSLayoutAttribute, to size: CGFloat,
                              relation: NSLayoutRelation = .equal) -> ItemConstraint<ConstrainableItem> {
        return constrain(attribute, to: .notAnAttribute, of: nil, multiplier: 0, offset: size, relation: relation)
    }

    @discardableResult
    public func constrainSize<C: Constrainable>(to constrainable: C) -> ItemConstraints<ConstrainableItem> {
        return constrain(to: [.width, .height], of: constrainable)
    }

    @discardableResult
    public func constrain<C: Constrainable>(to attributes: [NSLayoutAttribute],
                                            of constrainable: C) -> ItemConstraints<ConstrainableItem> {
        return itemConstraints(with: attributes.map { constrain(to: $0, of: constrainable) })
    }

    @discardableResult
    public func constrain<C: Constrainable>(
        to attribute: NSLayoutAttribute,
        of constrainable: C,
        multiplier: CGFloat = 1,
        offset: CGFloat = 0,
        relation: NSLayoutRelation = .equal
    ) -> ItemConstraint<ConstrainableItem> {
        return constrain(attribute, to: attribute, of: constrainable.constrainableItem,
                         multiplier: multiplier, offset: offset, relation: relation)
    }

    @discardableResult
    public func constrain(
        _ attribute: NSLayoutAttribute,
        to toAttribute: NSLayoutAttribute,
        of item: AnyObject?,
        multiplier: CGFloat = 1,
        offset: CGFloat = 0,
        relation: NSLayoutRelation = .equal
    ) -> ItemConstraint<ConstrainableItem> {
        if let view = self as? View { view.translatesAutoresizingMaskIntoConstraints = false }
        let constraint = NSLayoutConstraint(item: constrainableItem, attribute: attribute, relatedBy: relation,
                                            toItem: item, attribute: toAttribute,
                                            multiplier: multiplier, constant: offset)
        constraint.isActive = true
        return ItemConstraint(constrainableItem: constrainableItem,
                              constraint: constraint,
                              allConstraints: allConstraints + [constraint])
    }

    func itemConstraints(with array: [ItemConstraint<ConstrainableItem>]) -> ItemConstraints<ConstrainableItem> {
        let constraints = array.map { $0.constraint }
        return ItemConstraints(constrainableItem: constrainableItem,
                               constraints: constraints,
                               allConstraints: allConstraints + constraints)
    }
}

extension Constrainable where ConstrainableItem: View {
    @discardableResult
    public func constrainToFillSuperview(
        _ attribute: NSLayoutAttribute? = nil,
        insets: EdgeInsets = EdgeInsets()
    ) -> ItemConstraints<ConstrainableItem> {
        var constraints = [ItemConstraint<ConstrainableItem>]()

        if attribute != .left && attribute != .leading && attribute != .height {
            constraints.append(constrainToSuperview(.trailing, offset: -insets.right))
        }
        if attribute != .right && attribute != .trailing && attribute != .height {
            constraints.append(constrainToSuperview(.leading, offset: insets.left))
        }
        if attribute != .top && attribute != .width {
            constraints.append(constrainToSuperview(.bottom, offset: -insets.bottom))
        }
        if attribute != .bottom && attribute != .width {
            constraints.append(constrainToSuperview(.top, offset: insets.top))
        }

        return itemConstraints(with: constraints)
    }

    @discardableResult
    public func constrainToPosition(
        _ attribute: NSLayoutAttribute,
        toSuperviewPercent percent: CGFloat,
        offset: CGFloat = 0,
        relation: NSLayoutRelation = .equal
    ) -> ItemConstraint<ConstrainableItem> {
        let toAttribute: NSLayoutAttribute

        switch attribute {
        case .left, .right, .leading, .trailing, .centerX: toAttribute = .right
        case .top, .bottom, .centerY: toAttribute = .bottom
        default: toAttribute = attribute
        }

        return constrain(attribute, toSuperview: toAttribute, multiplier: percent, offset: offset, relation: relation)
    }

    @discardableResult
    public func constrainCenterToSuperview() -> ItemConstraints<ConstrainableItem> {
        return constrainToSuperview([.centerX, .centerY])
    }

    @discardableResult
    public func constrainSizeToSuperview() -> ItemConstraints<ConstrainableItem> {
        return constrainToSuperview([.width, .height])
    }

    @discardableResult
    public func constrainToSuperview(_ attributes: [NSLayoutAttribute]) -> ItemConstraints<ConstrainableItem> {
        return itemConstraints(with: attributes.map { constrainToSuperview($0) })
    }

    @discardableResult
    public func constrainToSuperview(
        _ attribute: NSLayoutAttribute,
        multiplier: CGFloat = 1,
        offset: CGFloat = 0,
        relation: NSLayoutRelation = .equal
    ) -> ItemConstraint<ConstrainableItem> {
        return constrain(attribute.removingMargin, toSuperview: attribute,
                         multiplier: multiplier, offset: offset, relation: relation)
    }

    @discardableResult
    public func constrain(
        _ attribute: NSLayoutAttribute,
        toSuperview toAttribute: NSLayoutAttribute,
        multiplier: CGFloat = 1,
        offset: CGFloat = 0,
        relation: NSLayoutRelation = .equal
    ) -> ItemConstraint<ConstrainableItem> {
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
        @discardableResult
        public func constrainToPinToTopLayoutGuide(
            of viewController: UIViewController,
            inset: CGFloat = 0,
            relation: NSLayoutRelation = .equal
        ) -> ItemConstraint<ConstrainableItem> {
            return constrain(.top, to: .bottom, of: viewController.topLayoutGuide, offset: inset, relation: relation)
        }

        @discardableResult
        public func constrainToPinToBottomLayoutGuide(
            of viewController: UIViewController,
            inset: CGFloat = 0,
            relation: NSLayoutRelation = .equal
        ) -> ItemConstraint<ConstrainableItem> {
            return constrain(.bottom, to: .top, of: viewController.bottomLayoutGuide,
                             offset: -inset, relation: relation.reversed)
        }
    }

    extension Constrainable where ConstrainableItem: View {
        @discardableResult
        public func constrainToFillSuperviewMargins(_ attribute: NSLayoutAttribute? = nil)
            -> ItemConstraints<ConstrainableItem> {
            var constraints = [ItemConstraint<ConstrainableItem>]()

            if attribute != .leftMargin && attribute != .leadingMargin && attribute != .height {
                constraints.append(constrainToSuperview(.trailingMargin))
            }
            if attribute != .rightMargin && attribute != .trailingMargin && attribute != .height {
                constraints.append(constrainToSuperview(.leadingMargin))
            }
            if attribute != .topMargin && attribute != .width {
                constraints.append(constrainToSuperview(.bottomMargin))
            }
            if attribute != .bottomMargin && attribute != .width {
                constraints.append(constrainToSuperview(.topMargin))
            }
            
            return itemConstraints(with: constraints)
        }

        @discardableResult
        public func constrainCenterToSuperviewMargins() -> ItemConstraints<ConstrainableItem> {
            return constrainToSuperview([.centerXWithinMargins, .centerYWithinMargins])
        }
    }

    @available(iOS 9.0, *)
    extension UILayoutGuide: Constrainable {
        public var constrainableItem: UILayoutGuide { return self }
        public var allConstraints: [NSLayoutConstraint] { return [] }
    }
#endif
