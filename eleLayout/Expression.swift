//
//  Expression.swift
//  eleLayout
//
//  Created by Javier on 10/27/16.
//  Copyright © 2016 Javier. All rights reserved.
//

#if os(iOS)
    import UIKit
#else
    import AppKit
#endif

public struct ConstraintParameter {
    var item: AnyObject?
    var attribute: NSLayoutAttribute?
    var multiplier: CGFloat = 1
    var constant: CGFloat = 0
    var relation: NSLayoutRelation = .equal
    var priority: UILayoutPriority = UILayoutPriorityRequired

    init(constant: CGFloat) { self.constant = constant }

    init(item: AnyObject?, attribute: NSLayoutAttribute? = nil) {
        self.item = item
        self.attribute = attribute
    }

    func modified(_ modify: (inout ConstraintParameter) -> ()) -> ConstraintParameter {
        var parameter = self
        modify(&parameter)
        return parameter
    }
}

public protocol ConstraintExpression {
    var constraintParameter: ConstraintParameter { get }
}

extension ConstraintParameter: ConstraintExpression {
    public var constraintParameter: ConstraintParameter { return self }
}

extension Int: ConstraintExpression {
    public var constraintParameter: ConstraintParameter {
        return ConstraintParameter(constant: CGFloat(self))
    }
}

extension Double: ConstraintExpression {
    public var constraintParameter: ConstraintParameter {
        return ConstraintParameter(constant: CGFloat(self))
    }
}

extension CGFloat: ConstraintExpression {
    public var constraintParameter: ConstraintParameter {
        return ConstraintParameter(constant: self)
    }
}

extension View: ConstraintExpression {
    public var constraintParameter: ConstraintParameter {
        return ConstraintParameter(item: self)
    }
}

#if os(iOS)
    @available(iOS 9.0, *)
    extension UILayoutGuide: ConstraintExpression {
        public var constraintParameter: ConstraintParameter {
            return ConstraintParameter(item: self)
        }
    }
#endif
