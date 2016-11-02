//
//  ItemsAttributeFunctions.swift
//  Bamboo
//
//  Created by Javier on 10/28/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import Foundation

extension ConstraintItemsChain {
    @discardableResult
    public func left() -> ConstraintItemsMany<Item> {
        return attribute { $0.left }
    }

    @discardableResult
    public func right() -> ConstraintItemsMany<Item> {
        return attribute { $0.right }
    }

    @discardableResult
    public func top() -> ConstraintItemsMany<Item> {
        return attribute { $0.top }
    }

    @discardableResult
    public func bottom() -> ConstraintItemsMany<Item> {
        return attribute { $0.bottom }
    }

    @discardableResult
    public func leading() -> ConstraintItemsMany<Item> {
        return attribute { $0.leading }
    }

    @discardableResult
    public func trailing() -> ConstraintItemsMany<Item> {
        return attribute { $0.trailing }
    }

    @discardableResult
    public func width() -> ConstraintItemsMany<Item> {
        return attribute { $0.width }
    }

    @discardableResult
    public func height() -> ConstraintItemsMany<Item> {
        return attribute { $0.height }
    }

    @discardableResult
    public func centerX() -> ConstraintItemsMany<Item> {
        return attribute { $0.centerX }
    }

    @discardableResult
    public func centerY() -> ConstraintItemsMany<Item> {
        return attribute { $0.centerY }
    }

    @discardableResult
    public func lastBaseline() -> ConstraintItemsMany<Item> {
        return attribute { $0.lastBaseline }
    }

    @discardableResult
    public func firstBaseline() -> ConstraintItemsMany<Item> {
        return attribute { $0.firstBaseline }
    }

    private func attribute(
        _ attributeFunction: (ConstraintNone<Item>) -> (ConstraintExpression) -> ConstraintOne<Item>
    ) -> ConstraintItemsMany<Item> {
        return between { attributeFunction($1.constrain)(ConstraintParameter(item: $0)) }
    }
}
