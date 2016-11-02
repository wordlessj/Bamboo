//
//  CompoundFunctions.swift
//  Bamboo
//
//  Created by Javier on 10/27/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import Foundation

extension ConstraintChain {
    @discardableResult
    public func center(_ expression: ConstraintExpression? = nil) -> ConstraintMany<Item> {
        return constraintMany([centerX(expression), centerY(expression)])
    }

    @discardableResult
    public func size(_ expression: ConstraintExpression? = nil) -> ConstraintMany<Item> {
        return constraintMany([width(expression), height(expression)])
    }

    @discardableResult
    public func size(_ cgSize: CGSize) -> ConstraintMany<Item> {
        return size(width: cgSize.width, height: cgSize.height)
    }

    @discardableResult
    public func size(width w: CGFloat, height h: CGFloat) -> ConstraintMany<Item> {
        return constraintMany([width(w), height(h)])
    }

    func constraintMany(_ array: [ConstraintOne<Item>]) -> ConstraintMany<Item> {
        let constraints = array.map { $0.constraint }
        return ConstraintMany(item: item, constraints: constraints, allConstraints: allConstraints + constraints)
    }
}

#if os(iOS)
    extension ConstraintChain {
        @discardableResult
        public func centerWithinMargins(_ expression: ConstraintExpression? = nil) -> ConstraintMany<Item> {
            return constraintMany([centerXWithinMargins(expression), centerYWithinMargins(expression)])
        }
    }
#endif
