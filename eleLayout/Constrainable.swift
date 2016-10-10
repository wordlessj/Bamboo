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

public struct ItemNoConstraints<Item: ConstrainableItem>: Constrainable {
    public var item: Item
    public var allConstraints: [NSLayoutConstraint]
}

public struct ItemConstraint<Item: ConstrainableItem>: Constrainable {
    public var item: Item
    public var constraint: NSLayoutConstraint
    public var allConstraints: [NSLayoutConstraint]
}

public struct ItemConstraints<Item: ConstrainableItem>: Constrainable {
    public var item: Item
    public var constraints: [NSLayoutConstraint]
    public var allConstraints: [NSLayoutConstraint]
}

public protocol ConstrainableItem: AnyObject {}

extension ConstrainableItem {
    public var constrain: ItemNoConstraints<Self> {
        return ItemNoConstraints(item: self, allConstraints: [])
    }
}

extension View: ConstrainableItem {}

public protocol Constrainable {
    associatedtype Item: ConstrainableItem
    var item: Item { get }
    var allConstraints: [NSLayoutConstraint] { get }
}

extension Constrainable {
    @discardableResult
    public func pin<I: ConstrainableItem>(
        to attribute: NSLayoutAttribute,
        of item: I,
        spacing: CGFloat = 0,
        relation: NSLayoutRelation = .equal
    ) -> ItemConstraint<Item> {
        let offset: CGFloat

        switch attribute {
        case .left, .top, .leading: offset = -spacing
        default: offset = spacing
        }

        return with(attribute.flipped, to: attribute, of: item, offset: offset, relation: relation)
    }

    @discardableResult
    public func size(_ cgSize: CGSize) -> ItemConstraints<Item> {
        return itemConstraints(with: [size(.width, to: cgSize.width), size(.height, to: cgSize.height)])
    }

    @discardableResult
    public func size(_ attribute: NSLayoutAttribute, to size: CGFloat,
                     relation: NSLayoutRelation = .equal) -> ItemConstraint<Item> {
        return with(attribute, to: .notAnAttribute, of: nil, multiplier: 0, offset: size, relation: relation)
    }

    @discardableResult
    public func size<I: ConstrainableItem>(to item: I) -> ItemConstraints<Item> {
        return to([.width, .height], of: item)
    }

    @discardableResult
    public func sizeToSelf(widthToHeightRatio: CGFloat, offset: CGFloat = 0,
                           relation: NSLayoutRelation = .equal) -> ItemConstraint<Item> {
        return sizeToSelf(heightToWidthRatio: 1 / widthToHeightRatio, offset: -offset, relation: relation.reversed)
    }

    @discardableResult
    public func sizeToSelf(heightToWidthRatio: CGFloat = 1, offset: CGFloat = 0,
                           relation: NSLayoutRelation = .equal) -> ItemConstraint<Item> {
        return with(.height, to: .width, of: item, multiplier: heightToWidthRatio, offset: offset, relation: relation)
    }

    @discardableResult
    public func to<I: ConstrainableItem>(_ attributes: [NSLayoutAttribute],
                                         of item: I) -> ItemConstraints<Item> {
        return itemConstraints(with: attributes.map { to($0, of: item) })
    }

    @discardableResult
    public func to<I: ConstrainableItem>(
        _ attribute: NSLayoutAttribute,
        of item: I,
        multiplier: CGFloat = 1,
        offset: CGFloat = 0,
        relation: NSLayoutRelation = .equal
    ) -> ItemConstraint<Item> {
        return with(attribute, to: attribute, of: item, multiplier: multiplier, offset: offset, relation: relation)
    }

    @discardableResult
    public func with(
        _ attribute: NSLayoutAttribute,
        to toAttribute: NSLayoutAttribute,
        of toItem: AnyObject?,
        multiplier: CGFloat = 1,
        offset: CGFloat = 0,
        relation: NSLayoutRelation = .equal
    ) -> ItemConstraint<Item> {
        if let view = item as? View { view.translatesAutoresizingMaskIntoConstraints = false }
        let constraint = NSLayoutConstraint(item: item, attribute: attribute, relatedBy: relation,
                                            toItem: toItem, attribute: toAttribute,
                                            multiplier: multiplier, constant: offset)
        constraint.isActive = true
        return ItemConstraint(item: item, constraint: constraint, allConstraints: allConstraints + [constraint])
    }

    fileprivate func itemConstraints(with array: [ItemConstraint<Item>]) -> ItemConstraints<Item> {
        let constraints = array.map { $0.constraint }
        return ItemConstraints(item: item, constraints: constraints, allConstraints: allConstraints + constraints)
    }
}

extension Constrainable where Item: View {
    @discardableResult
    public func fillSuperview(
        _ attribute: NSLayoutAttribute? = nil,
        insets: EdgeInsets = EdgeInsets()
    ) -> ItemConstraints<Item> {
        var constraints = [ItemConstraint<Item>]()

        if attribute != .left && attribute != .leading && attribute != .height {
            constraints.append(toSuperview(.trailing, offset: -insets.right))
        }
        if attribute != .right && attribute != .trailing && attribute != .height {
            constraints.append(toSuperview(.leading, offset: insets.left))
        }
        if attribute != .top && attribute != .width {
            constraints.append(toSuperview(.bottom, offset: -insets.bottom))
        }
        if attribute != .bottom && attribute != .width {
            constraints.append(toSuperview(.top, offset: insets.top))
        }

        return itemConstraints(with: constraints)
    }

    @discardableResult
    public func position(
        _ attribute: NSLayoutAttribute,
        toSuperviewRatio ratio: CGFloat,
        offset: CGFloat = 0,
        relation: NSLayoutRelation = .equal
    ) -> ItemConstraint<Item> {
        let toAttribute: NSLayoutAttribute

        switch attribute {
        case .left, .right, .leading, .trailing, .centerX: toAttribute = .right
        case .top, .bottom, .centerY: toAttribute = .bottom
        default: toAttribute = attribute
        }

        return with(attribute, toSuperview: toAttribute, multiplier: ratio, offset: offset, relation: relation)
    }

    @discardableResult
    public func centerInSuperview() -> ItemConstraints<Item> {
        return toSuperview([.centerX, .centerY])
    }

    @discardableResult
    public func sizeToSuperview() -> ItemConstraints<Item> {
        return toSuperview([.width, .height])
    }

    @discardableResult
    public func toSuperview(_ attributes: [NSLayoutAttribute]) -> ItemConstraints<Item> {
        return itemConstraints(with: attributes.map { toSuperview($0) })
    }

    @discardableResult
    public func toSuperview(
        _ attribute: NSLayoutAttribute,
        multiplier: CGFloat = 1,
        offset: CGFloat = 0,
        relation: NSLayoutRelation = .equal
    ) -> ItemConstraint<Item> {
        return with(attribute.removingMargin, toSuperview: attribute,
                    multiplier: multiplier, offset: offset, relation: relation)
    }

    @discardableResult
    public func with(
        _ attribute: NSLayoutAttribute,
        toSuperview toAttribute: NSLayoutAttribute,
        multiplier: CGFloat = 1,
        offset: CGFloat = 0,
        relation: NSLayoutRelation = .equal
    ) -> ItemConstraint<Item> {
        return with(attribute, to: toAttribute, of: item.superview,
                    multiplier: multiplier, offset: offset, relation: relation)
    }
}

#if os(iOS)
    @available(iOS 9.0, *)
    extension UILayoutGuide: ConstrainableItem {}

    extension Constrainable {
        @discardableResult
        public func pinToTopLayoutGuide(
            of viewController: UIViewController,
            inset: CGFloat = 0,
            relation: NSLayoutRelation = .equal
        ) -> ItemConstraint<Item> {
            return with(.top, to: .bottom, of: viewController.topLayoutGuide, offset: inset, relation: relation)
        }

        @discardableResult
        public func pinToBottomLayoutGuide(
            of viewController: UIViewController,
            inset: CGFloat = 0,
            relation: NSLayoutRelation = .equal
        ) -> ItemConstraint<Item> {
            return with(.bottom, to: .top, of: viewController.bottomLayoutGuide,
                        offset: -inset, relation: relation.reversed)
        }
    }

    extension Constrainable where Item: View {
        @discardableResult
        public func fillSuperviewMargins(_ attribute: NSLayoutAttribute? = nil)
            -> ItemConstraints<Item> {
            var constraints = [ItemConstraint<Item>]()

            if attribute != .leftMargin && attribute != .leadingMargin && attribute != .height {
                constraints.append(toSuperview(.trailingMargin))
            }
            if attribute != .rightMargin && attribute != .trailingMargin && attribute != .height {
                constraints.append(toSuperview(.leadingMargin))
            }
            if attribute != .topMargin && attribute != .width {
                constraints.append(toSuperview(.bottomMargin))
            }
            if attribute != .bottomMargin && attribute != .width {
                constraints.append(toSuperview(.topMargin))
            }
            
            return itemConstraints(with: constraints)
        }

        @discardableResult
        public func centerInSuperviewMargins() -> ItemConstraints<Item> {
            return toSuperview([.centerXWithinMargins, .centerYWithinMargins])
        }
    }
#endif
