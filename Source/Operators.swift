//
//  Operators.swift
//  Bamboo
//
//  Created by Javier on 10/27/16.
//  Copyright © 2016 Javier. All rights reserved.
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
