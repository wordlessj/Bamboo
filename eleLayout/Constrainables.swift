//
//  Constrainables.swift
//  eleLayout
//
//  Created by Javier on 10/7/16.
//  Copyright © 2016 Javier. All rights reserved.
//

#if os(iOS)
    import UIKit
#else
    import AppKit
#endif

public struct ItemsNoConstraints<Item: ConstrainableItem>: Constrainables {
    public var items: [Item]
    public var allConstraints: [NSLayoutConstraint]
}

public struct ItemsConstraints<Item: ConstrainableItem>: Constrainables {
    public var items: [Item]
    public var constraints: [NSLayoutConstraint]
    public var allConstraints: [NSLayoutConstraint]
}

extension Array where Element: ConstrainableItem {
    public var constrain: ItemsNoConstraints<Element> {
        return ItemsNoConstraints(items: self, allConstraints: [])
    }
}

public protocol Constrainables {
    associatedtype Item: ConstrainableItem
    var items: [Item] { get }
    var allConstraints: [NSLayoutConstraint] { get }
}

extension Constrainables {
    @discardableResult
    public func pin(to attribute: NSLayoutAttribute, spacing: CGFloat = 0) -> ItemsConstraints<Item> {
        return toPrevious { item, previousItem in
            item.constrain.pin(to: attribute, of: previousItem, spacing: spacing)
        }
    }

    @discardableResult
    public func size(_ cgSize: CGSize) -> ItemsConstraints<Item> {
        return each { $0.constrain.size(cgSize).constraints }
    }

    @discardableResult
    public func size(_ attribute: NSLayoutAttribute, to size: CGFloat) -> ItemsConstraints<Item> {
        return each { $0.constrain.size(attribute, to: size) }
    }

    @discardableResult
    public func size() -> ItemsConstraints<Item> {
        return to([.width, .height])
    }

    @discardableResult
    public func to(_ attributes: [NSLayoutAttribute]) -> ItemsConstraints<Item> {
        return itemsConstraints(with: attributes.flatMap { to($0).constraints })
    }

    @discardableResult
    public func to(_ attribute: NSLayoutAttribute) -> ItemsConstraints<Item> {
        return toPrevious { item, previousItem in
            item.constrain.to(attribute, of: previousItem)
        }
    }

    @discardableResult
    public func each(constrain: (Item) -> ItemConstraint<Item>) -> ItemsConstraints<Item> {
        return each { [constrain($0).constraint] }
    }

    @discardableResult
    public func each(constrain: (Item) -> [NSLayoutConstraint]) -> ItemsConstraints<Item> {
        return itemsConstraints(with: items.flatMap { constrain($0) })
    }

    @discardableResult
    public func toPrevious(
        constrain: (_ item: Item, _ previousItem: Item) -> ItemConstraint<Item>
    ) -> ItemsConstraints<Item> {
        return toPrevious { [constrain($0, $1).constraint] }
    }

    @discardableResult
    public func toPrevious(
        constrain: (_ item: Item, _ previousItem: Item) -> [NSLayoutConstraint]
    ) -> ItemsConstraints<Item> {
        var constraints = [NSLayoutConstraint]()
        var previousItem: Item?

        for item in items {
            if let previousItem = previousItem {
                constraints.append(contentsOf: constrain(item, previousItem))
            }

            previousItem = item
        }

        return itemsConstraints(with: constraints)
    }

    private func itemsConstraints(with constraints: [NSLayoutConstraint]) -> ItemsConstraints<Item> {
        return ItemsConstraints(items: items, constraints: constraints, allConstraints: allConstraints + constraints)
    }
}
