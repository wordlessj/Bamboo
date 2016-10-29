//
//  Operators.swift
//  eleLayout
//
//  Created by Javier on 10/27/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import Foundation

public func + (constant: CGFloat, expression: ConstraintExpression) -> ConstraintExpression {
        return expression.constraintParameter.modified { $0.constant += constant }
}

public func + (expression: ConstraintExpression, constant: CGFloat) -> ConstraintExpression {
        return constant + expression
}

public func - (expression: ConstraintExpression, constant: CGFloat) -> ConstraintExpression {
        return -constant + expression
}

public func * (multiplier: CGFloat, expression: ConstraintExpression) -> ConstraintExpression {
        return expression.constraintParameter.modified {
            $0.multiplier *= multiplier
            $0.constant *= multiplier
        }
}

public func * (expression: ConstraintExpression, multiplier: CGFloat) -> ConstraintExpression {
        return multiplier * expression
}

public func / (expression: ConstraintExpression, multiplier: CGFloat) -> ConstraintExpression {
        return 1 / multiplier * expression
}

prefix operator >=

public prefix func >= (expression: ConstraintExpression) -> ConstraintExpression {
        return expression.constraintParameter.modified { $0.relation = .greaterThanOrEqual }
}

prefix operator <=

public prefix func <= (expression: ConstraintExpression) -> ConstraintExpression {
        return expression.constraintParameter.modified { $0.relation = .lessThanOrEqual }
}

infix operator ~ : PriorityPrecedence

precedencegroup PriorityPrecedence {
    lowerThan: AdditionPrecedence
}

public func ~ (expression: ConstraintExpression, priority: UILayoutPriority) -> ConstraintExpression {
        return expression.constraintParameter.modified { $0.priority = priority }
}
