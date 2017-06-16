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
    public func center() -> MultipleChain<Item> {
        return center(BasicParameter<View>())
    }

    @discardableResult
    public func center<Expression: ParameterExpression>(_ expression: Expression) -> MultipleChain<Item>
        where Expression.Parameter.Item: XAxisItem & YAxisItem, Expression.Parameter: BasicParameterProtocol {
            return merge([centerX(expression), centerY(expression)])
    }

    @discardableResult
    public func size() -> MultipleChain<Item> {
        return size(BasicParameter<View>(item: item.superview!))
    }

    @discardableResult
    public func size<Expression: ParameterExpression>(_ expression: Expression) -> MultipleChain<Item>
        where Expression.Parameter.Item: DimensionItem {
            return merge([width(expression), height(expression)])
    }

    @discardableResult
    public func size(_ cgSize: CGSize) -> MultipleChain<Item> {
        return size(width: cgSize.width, height: cgSize.height)
    }

    @discardableResult
    public func size(width w: CGFloat, height h: CGFloat) -> MultipleChain<Item> {
        return merge([width(w), height(h)])
    }
}
