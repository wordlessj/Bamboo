//
//  AttributeFunctions.swift
//  Bamboo
//
//  Created by Javier on 10/27/16.
//  Copyright © 2016 Javier. All rights reserved.
//

#if os(iOS)
    import UIKit
#else
    import AppKit
#endif

extension ConstraintChain {
    @discardableResult
    public func left(_ expression: ConstraintExpression? = nil) -> ConstraintOne<Item> {
        return raw(.left, expression: expression)
    }

    @discardableResult
    public func right(_ expression: ConstraintExpression? = nil) -> ConstraintOne<Item> {
        return raw(.right, expression: expression)
    }

    @discardableResult
    public func top(_ expression: ConstraintExpression? = nil) -> ConstraintOne<Item> {
        return raw(.top, expression: expression)
    }

    @discardableResult
    public func bottom(_ expression: ConstraintExpression? = nil) -> ConstraintOne<Item> {
        return raw(.bottom, expression: expression)
    }

    @discardableResult
    public func leading(_ expression: ConstraintExpression? = nil) -> ConstraintOne<Item> {
        return raw(.leading, expression: expression)
    }

    @discardableResult
    public func trailing(_ expression: ConstraintExpression? = nil) -> ConstraintOne<Item> {
        return raw(.trailing, expression: expression)
    }

    @discardableResult
    public func width(_ expression: ConstraintExpression? = nil) -> ConstraintOne<Item> {
        return raw(.width, expression: expression)
    }

    @discardableResult
    public func height(_ expression: ConstraintExpression? = nil) -> ConstraintOne<Item> {
        return raw(.height, expression: expression)
    }

    @discardableResult
    public func centerX(_ expression: ConstraintExpression? = nil) -> ConstraintOne<Item> {
        return raw(.centerX, expression: expression)
    }

    @discardableResult
    public func centerY(_ expression: ConstraintExpression? = nil) -> ConstraintOne<Item> {
        return raw(.centerY, expression: expression)
    }

    @discardableResult
    public func lastBaseline(_ expression: ConstraintExpression? = nil) -> ConstraintOne<Item> {
        return raw(.lastBaseline, expression: expression)
    }

    @discardableResult
    public func firstBaseline(_ expression: ConstraintExpression? = nil) -> ConstraintOne<Item> {
        return raw(.firstBaseline, expression: expression)
    }

    @discardableResult
    public func aspectRatio(_ ratio: CGFloat = 1) -> ConstraintOne<Item> {
        return width(ratio * height)
    }

    fileprivate func raw(
        _ attribute: NSLayoutAttribute,
        expression: ConstraintExpression?
    ) -> ConstraintOne<Item> {
        let constraintOne: ConstraintOne<Item>

        if let parameter = expression?.constraintParameter {
            if (attribute == .width || attribute == .height) && parameter.item == nil {
                constraintOne = raw(attribute,
                                    to: nil,
                                    attribute: .notAnAttribute,
                                    multiplier: 1,
                                    constant: parameter.constant,
                                    relation: parameter.relation,
                                    priority: parameter.priority)
            } else {
                constraintOne = raw(attribute,
                                    to: parameter.item ?? item.superview,
                                    attribute: parameter.attribute ?? attribute,
                                    multiplier: parameter.multiplier,
                                    constant: parameter.constant,
                                    relation: parameter.relation,
                                    priority: parameter.priority)
            }
        } else {
            constraintOne = raw(attribute, to: item.superview, attribute: attribute)
        }

        return constraintOne
    }

    private func raw(
        _ attribute: NSLayoutAttribute,
        to toItem: AnyObject?,
        attribute toAttribute: NSLayoutAttribute,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        relation: NSLayoutRelation = .equal,
        priority: UILayoutPriority = UILayoutPriorityRequired
    ) -> ConstraintOne<Item> {
        if let view = item as? View { view.translatesAutoresizingMaskIntoConstraints = false }
        let constraint = NSLayoutConstraint(item: item, attribute: attribute, relatedBy: relation,
                                            toItem: toItem, attribute: toAttribute,
                                            multiplier: multiplier, constant: constant)
        constraint.priority = priority
        constraint.isActive = true
        return ConstraintOne(item: item, constraint: constraint, allConstraints: allConstraints + [constraint])
    }
}

#if os(iOS)
    extension ConstraintChain {
        @discardableResult
        public func leftMargin(_ expression: ConstraintExpression? = nil) -> ConstraintOne<Item> {
            return raw(.leftMargin, expression: expression)
        }

        @discardableResult
        public func rightMargin(_ expression: ConstraintExpression? = nil) -> ConstraintOne<Item> {
            return raw(.rightMargin, expression: expression)
        }

        @discardableResult
        public func topMargin(_ expression: ConstraintExpression? = nil) -> ConstraintOne<Item> {
            return raw(.topMargin, expression: expression)
        }

        @discardableResult
        public func bottomMargin(_ expression: ConstraintExpression? = nil) -> ConstraintOne<Item> {
            return raw(.bottomMargin, expression: expression)
        }

        @discardableResult
        public func leadingMargin(_ expression: ConstraintExpression? = nil) -> ConstraintOne<Item> {
            return raw(.leadingMargin, expression: expression)
        }

        @discardableResult
        public func trailingMargin(_ expression: ConstraintExpression? = nil) -> ConstraintOne<Item> {
            return raw(.trailingMargin, expression: expression)
        }

        @discardableResult
        public func centerXWithinMargins(_ expression: ConstraintExpression? = nil) -> ConstraintOne<Item> {
            return raw(.centerXWithinMargins, expression: expression)
        }

        @discardableResult
        public func centerYWithinMargins(_ expression: ConstraintExpression? = nil) -> ConstraintOne<Item> {
            return raw(.centerYWithinMargins, expression: expression)
        }
    }
#endif
