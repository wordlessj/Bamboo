//
//  ItemsFunctions.swift
//  Bamboo
//
//  Created by Javier on 10/28/16.
//  Copyright © 2016 Javier. All rights reserved.
//

#if os(iOS)
    import UIKit
#else
    import AppKit
#endif

extension ConstraintItemsChain {
    @discardableResult
    public func each(constrain: (Item) -> ConstraintOne<Item>) -> ConstraintItemsMany<Item> {
        return each { [constrain($0).constraint] }
    }

    @discardableResult
    public func each(constrain: (Item) -> [NSLayoutConstraint]) -> ConstraintItemsMany<Item> {
        return constraintItemsMany(items.flatMap { constrain($0) })
    }

    @discardableResult
    public func between(
        constrain: (_ first: Item, _ second: Item) -> ConstraintOne<Item>
    ) -> ConstraintItemsMany<Item> {
        return between { [constrain($0, $1).constraint] }
    }

    @discardableResult
    public func between(
        constrain: (_ first: Item, _ second: Item) -> [NSLayoutConstraint]
    ) -> ConstraintItemsMany<Item> {
        var constraints = [NSLayoutConstraint]()
        var previousItem: Item?

        for item in items {
            if let previousItem = previousItem {
                constraints.append(contentsOf: constrain(previousItem, item))
            }

            previousItem = item
        }

        return constraintItemsMany(constraints)
    }

    func constraintItemsMany(_ constraints: [NSLayoutConstraint]) -> ConstraintItemsMany<Item> {
        return ConstraintItemsMany(items: items,
                                   constraints: constraints,
                                   allConstraints: allConstraints + constraints)
    }
}
