//
//  Operators.swift
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

/// System spacing placeholder.
public struct SystemSpacing {
    public var multiplier: CGFloat

    public init(_ multiplier: CGFloat = 1) {
        self.multiplier = multiplier
    }
}

public func + <Expression: ParameterExpression>(constant: CGFloat, expression: Expression)
    -> Expression.Parameter.AddedParameter {
        return expression.constraintParameter.added(constant)
}

public func + <Expression: ParameterExpression>(expression: Expression, constant: CGFloat)
    -> Expression.Parameter.AddedParameter {
        return constant + expression
}

#if os(iOS) || os(tvOS)
@available(iOS 11.0, tvOS 11.0, *)
public func + <Expression: ParameterExpression>(expression: Expression, spacing: SystemSpacing)
    -> SystemSpacingParameter<Expression.Parameter.Item>
    where Expression.Parameter: SystemSpacingParameterConvertible {
        return SystemSpacingParameter(expression.constraintParameter, multiplier: spacing.multiplier)
}
#endif

public func - <Expression: ParameterExpression>(expression: Expression, constant: CGFloat)
    -> Expression.Parameter.AddedParameter {
        return -constant + expression
}

public func * <Expression: ParameterExpression>(multiplier: CGFloat, expression: Expression)
    -> Expression.Parameter.MultipliedParameter {
        return expression.constraintParameter.multiplied(multiplier)
}

public func * <Expression: ParameterExpression>(expression: Expression, multiplier: CGFloat)
    -> Expression.Parameter.MultipliedParameter {
        return multiplier * expression
}

public func / <Expression: ParameterExpression>(expression: Expression, multiplier: CGFloat)
    -> Expression.Parameter.MultipliedParameter {
        return 1 / multiplier * expression
}

prefix operator >=

public prefix func >= <Expression: ParameterExpression>(expression: Expression) -> Expression.Parameter {
    return expression.constraintParameter.modified { $0.relation = .greaterThanOrEqual }
}

prefix operator <=

public prefix func <= <Expression: ParameterExpression>(expression: Expression) -> Expression.Parameter {
    return expression.constraintParameter.modified { $0.relation = .lessThanOrEqual }
}

infix operator ~ : PriorityPrecedence

precedencegroup PriorityPrecedence {
    lowerThan: AdditionPrecedence
}

public func ~ <Expression: ParameterExpression>
    (expression: Expression, priority: Float) -> Expression.Parameter {
    return expression ~ LayoutPriority(rawValue: priority)
}

public func ~ <Expression: ParameterExpression>
    (expression: Expression, priority: LayoutPriority) -> Expression.Parameter {
    return expression.constraintParameter.modified { $0.priority = priority }
}

@available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
public func - (anchor1: NSLayoutXAxisAnchor, anchor2: NSLayoutXAxisAnchor) -> NSLayoutDimension {
    return anchor2.anchorWithOffset(to: anchor1)
}

@available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
public func - (anchor1: NSLayoutYAxisAnchor, anchor2: NSLayoutYAxisAnchor) -> NSLayoutDimension {
    return anchor2.anchorWithOffset(to: anchor1)
}
