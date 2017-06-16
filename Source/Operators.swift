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

public func + <Expression: ParameterExpression>(constant: CGFloat, expression: Expression) -> Expression.Parameter {
    return expression.constraintParameter.modified { $0.constant += constant }
}

public func + <Expression: ParameterExpression>(expression: Expression, constant: CGFloat) -> Expression.Parameter {
    return constant + expression
}

public func - <Expression: ParameterExpression>(expression: Expression, constant: CGFloat) -> Expression.Parameter {
    return -constant + expression
}

public func * <Expression: ParameterExpression>(multiplier: CGFloat, expression: Expression)
    -> MultiplierParameter<Expression.Parameter.Item> {
        return expression.constraintParameter.multiplied(multiplier)
}

public func * <Expression: ParameterExpression>(expression: Expression, multiplier: CGFloat)
    -> MultiplierParameter<Expression.Parameter.Item> {
        return multiplier * expression
}

public func / <Expression: ParameterExpression>(expression: Expression, multiplier: CGFloat)
    -> MultiplierParameter<Expression.Parameter.Item> {
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
    (expression: Expression, priority: LayoutPriority) -> Expression.Parameter {
    return expression.constraintParameter.modified { $0.priority = priority }
}
