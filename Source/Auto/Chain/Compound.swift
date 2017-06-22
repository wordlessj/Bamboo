//
//  Compound.swift
//  Bamboo
//
//  Copyright (c) 2017 Javier Zhang (https://wordlessj.github.io/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
            return toMultipleChain.centerX(expression).centerY(expression)
    }

    @discardableResult
    public func size() -> MultipleChain<Item> {
        return size(BasicParameter<View>(item: item.superview!))
    }

    @discardableResult
    public func size<Expression: ParameterExpression>(_ expression: Expression) -> MultipleChain<Item>
        where Expression.Parameter.Item: DimensionItem {
            return toMultipleChain.width(expression).height(expression)
    }

    @discardableResult
    public func size(_ cgSize: CGSize) -> MultipleChain<Item> {
        return size(width: cgSize.width, height: cgSize.height)
    }

    @discardableResult
    public func size(width w: CGFloat, height h: CGFloat) -> MultipleChain<Item> {
        return toMultipleChain.width(w).height(h)
    }
}
