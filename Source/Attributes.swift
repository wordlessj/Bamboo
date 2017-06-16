//
//  Attributes.swift
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
    public func left() -> NextChain {
        return left(BasicParameter<View>())
    }

    @discardableResult
    public func left<Expression: ParameterExpression>(_ expression: Expression) -> NextChain
        where Expression.Parameter.Item: XAxisItem, Expression.Parameter: BasicParameterProtocol {
            return solve(expression) { $0.leftAnchor }
    }

    @discardableResult
    public func right() -> NextChain {
        return right(BasicParameter<View>())
    }

    @discardableResult
    public func right<Expression: ParameterExpression>(_ expression: Expression) -> NextChain
        where Expression.Parameter.Item: XAxisItem, Expression.Parameter: BasicParameterProtocol {
            return solve(expression) { $0.rightAnchor }
    }

    @discardableResult
    public func top() -> NextChain {
        return top(BasicParameter<View>())
    }

    @discardableResult
    public func top<Expression: ParameterExpression>(_ expression: Expression) -> NextChain
        where Expression.Parameter.Item: YAxisItem, Expression.Parameter: BasicParameterProtocol {
            return solve(expression) { $0.topAnchor }
    }

    @discardableResult
    public func bottom() -> NextChain {
        return bottom(BasicParameter<View>())
    }

    @discardableResult
    public func bottom<Expression: ParameterExpression>(_ expression: Expression) -> NextChain
        where Expression.Parameter.Item: YAxisItem, Expression.Parameter: BasicParameterProtocol {
            return solve(expression) { $0.bottomAnchor }
    }

    @discardableResult
    public func leading() -> NextChain {
        return leading(BasicParameter<View>())
    }

    @discardableResult
    public func leading<Expression: ParameterExpression>(_ expression: Expression) -> NextChain
        where Expression.Parameter.Item: XAxisItem, Expression.Parameter: BasicParameterProtocol {
            return solve(expression) { $0.leadingAnchor }
    }

    @discardableResult
    public func trailing() -> NextChain {
        return trailing(BasicParameter<View>())
    }

    @discardableResult
    public func trailing<Expression: ParameterExpression>(_ expression: Expression) -> NextChain
        where Expression.Parameter.Item: XAxisItem, Expression.Parameter: BasicParameterProtocol {
            return solve(expression) { $0.trailingAnchor }
    }

    @discardableResult
    public func width() -> NextChain {
        return width(BasicParameter<View>(item: item.superview!))
    }

    @discardableResult
    public func width<Expression: ParameterExpression>(_ expression: Expression) -> NextChain
        where Expression.Parameter.Item: DimensionItem {
            return solve(expression) { $0.widthAnchor }
    }

    @discardableResult
    public func height() -> NextChain {
        return height(BasicParameter<View>(item: item.superview!))
    }

    @discardableResult
    public func height<Expression: ParameterExpression>(_ expression: Expression) -> NextChain
        where Expression.Parameter.Item: DimensionItem {
            return solve(expression) { $0.heightAnchor }
    }

    @discardableResult
    public func centerX() -> NextChain {
        return centerX(BasicParameter<View>())
    }

    @discardableResult
    public func centerX<Expression: ParameterExpression>(_ expression: Expression) -> NextChain
        where Expression.Parameter.Item: XAxisItem, Expression.Parameter: BasicParameterProtocol {
            return solve(expression) { $0.centerXAnchor }
    }

    @discardableResult
    public func centerY() -> NextChain {
        return centerY(BasicParameter<View>())
    }

    @discardableResult
    public func centerY<Expression: ParameterExpression>(_ expression: Expression) -> NextChain
        where Expression.Parameter.Item: YAxisItem, Expression.Parameter: BasicParameterProtocol {
            return solve(expression) { $0.centerYAnchor }
    }

    @discardableResult
    public func firstBaseline() -> NextChain {
        return firstBaseline(BasicParameter<View>())
    }

    @discardableResult
    public func firstBaseline<Expression: ParameterExpression>(_ expression: Expression) -> NextChain
        where Expression.Parameter.Item: YAxisItem, Expression.Parameter: BasicParameterProtocol {
            return solve(expression) { $0.firstBaselineAnchor }
    }

    @discardableResult
    public func lastBaseline() -> NextChain {
        return lastBaseline(BasicParameter<View>())
    }

    @discardableResult
    public func lastBaseline<Expression: ParameterExpression>(_ expression: Expression) -> NextChain
        where Expression.Parameter.Item: YAxisItem, Expression.Parameter: BasicParameterProtocol {
            return solve(expression) { $0.lastBaselineAnchor }
    }

    @discardableResult
    public func aspectRatio(_ ratio: CGFloat = 1) -> NextChain {
        return width(ratio * item.heightAnchor)
    }

    private func solve<Expression: ParameterExpression, AnchorType>(
        _ expression: Expression,
        anchorOf: (ConstraintItem) -> NSLayoutAnchor<AnchorType>
    ) -> NextChain {
        let parameter = expression.constraintParameter
        let anchor = anchorOf(item)
        let toAnchor: NSLayoutAnchor<AnchorType>?

        if let anchor = parameter.item as? NSLayoutAnchor<AnchorType> {
            toAnchor = anchor
        } else if let parameterItem = parameter.item as? ConstraintItem? {
            if anchor is NSLayoutDimension && parameterItem == nil {
                toAnchor = nil
            } else {
                let toItem = parameterItem ?? item.superview!
                toAnchor = anchorOf(toItem)
            }
        } else {
            fatalError("Unsupported expression item.")
        }

        let c = constraint(anchor, to: toAnchor, parameter: parameter)
        activate(c, priority: parameter.priority)
        return nextChain(c)
    }

    private func constraint<AnchorType, Parameter: ParameterProtocol>(
        _ anchor: NSLayoutAnchor<AnchorType>,
        to toAnchor: NSLayoutAnchor<AnchorType>?,
        parameter: Parameter
    ) -> NSLayoutConstraint {
        let constant = parameter.constant
        let constraint: NSLayoutConstraint

        if let anchor = anchor as? NSLayoutDimension, let toAnchor = toAnchor as? NSLayoutDimension? {
            if let toAnchor = toAnchor {
                let multiplier: CGFloat

                if let parameter = parameter as? MultiplierParameter<Parameter.Item> {
                    multiplier = parameter.multiplier
                } else {
                    multiplier = 1
                }

                switch parameter.relation {
                case .equal:
                    constraint = anchor.constraint(equalTo: toAnchor, multiplier: multiplier, constant: constant)
                case .greaterThanOrEqual:
                    constraint = anchor.constraint(greaterThanOrEqualTo: toAnchor,
                                                   multiplier: multiplier,
                                                   constant: constant)
                case .lessThanOrEqual:
                    constraint = anchor.constraint(lessThanOrEqualTo: toAnchor,
                                                   multiplier: multiplier,
                                                   constant: constant)
                }
            } else {
                switch parameter.relation {
                case .equal:
                    constraint = anchor.constraint(equalToConstant: constant)
                case .greaterThanOrEqual:
                    constraint = anchor.constraint(greaterThanOrEqualToConstant: constant)
                case .lessThanOrEqual:
                    constraint = anchor.constraint(lessThanOrEqualToConstant: constant)
                }
            }
        } else if let toAnchor = toAnchor {
            switch parameter.relation {
            case .equal:
                constraint = anchor.constraint(equalTo: toAnchor, constant: constant)
            case .greaterThanOrEqual:
                constraint = anchor.constraint(greaterThanOrEqualTo: toAnchor, constant: constant)
            case .lessThanOrEqual:
                constraint = anchor.constraint(lessThanOrEqualTo: toAnchor, constant: constant)
            }
        } else {
            fatalError("Axis anchor without second anchor.")
        }

        return constraint
    }

    private func activate(_ constraint: NSLayoutConstraint, priority: LayoutPriority) {
        if let view = item as? View { view.translatesAutoresizingMaskIntoConstraints = false }
        constraint.priority = priority
        constraint.isActive = true
    }
}
