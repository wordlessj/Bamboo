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
    /// Pin left to superview.
    @discardableResult
    public func left() -> NextChain {
        return left(BasicParameter<View>())
    }

    /// Pin left to `expression`.
    ///
    /// - parameter expression: Expression with optional `UIView`, `UILayoutGuide` or `NSLayoutXAxisAnchor`,
    ///     no multiplier.
    @discardableResult
    public func left<Expression: ParameterExpression>(_ expression: Expression) -> NextChain
        where Expression.Parameter.Item: XAxisItem, Expression.Parameter: BasicParameterProtocol {
            return solve(expression) { $0.leftAnchor }
    }

    /// Pin right to superview.
    @discardableResult
    public func right() -> NextChain {
        return right(BasicParameter<View>())
    }

    /// Pin right to `expression`.
    ///
    /// - parameter expression: Expression with optional `UIView`, `UILayoutGuide` or `NSLayoutXAxisAnchor`,
    ///     no multiplier.
    @discardableResult
    public func right<Expression: ParameterExpression>(_ expression: Expression) -> NextChain
        where Expression.Parameter.Item: XAxisItem, Expression.Parameter: BasicParameterProtocol {
            return solve(expression) { $0.rightAnchor }
    }

    /// Pin top to superview.
    @discardableResult
    public func top() -> NextChain {
        return top(BasicParameter<View>())
    }

    /// Pin top to `expression`.
    ///
    /// - parameter expression: Expression with optional `UIView`, `UILayoutGuide` or `NSLayoutYAxisAnchor`,
    ///     no multiplier.
    @discardableResult
    public func top<Expression: ParameterExpression>(_ expression: Expression) -> NextChain
        where Expression.Parameter.Item: YAxisItem, Expression.Parameter: BasicParameterProtocol {
            return solve(expression) { $0.topAnchor }
    }

    /// Pin bottom to superview.
    @discardableResult
    public func bottom() -> NextChain {
        return bottom(BasicParameter<View>())
    }

    /// Pin bottom to `expression`.
    ///
    /// - parameter expression: Expression with optional `UIView`, `UILayoutGuide` or `NSLayoutYAxisAnchor`,
    ///     no multiplier.
    @discardableResult
    public func bottom<Expression: ParameterExpression>(_ expression: Expression) -> NextChain
        where Expression.Parameter.Item: YAxisItem, Expression.Parameter: BasicParameterProtocol {
            return solve(expression) { $0.bottomAnchor }
    }

    /// Pin leading to superview.
    @discardableResult
    public func leading() -> NextChain {
        return leading(BasicParameter<View>())
    }

    /// Pin leading to `expression`.
    ///
    /// - parameter expression: Expression with optional `UIView`, `UILayoutGuide` or `NSLayoutXAxisAnchor`,
    ///     no multiplier.
    @discardableResult
    public func leading<Expression: ParameterExpression>(_ expression: Expression) -> NextChain
        where Expression.Parameter.Item: XAxisItem, Expression.Parameter: BasicParameterProtocol {
            return solve(expression) { $0.leadingAnchor }
    }

    /// Pin trailing to superview.
    @discardableResult
    public func trailing() -> NextChain {
        return trailing(BasicParameter<View>())
    }

    /// Pin trailing to `expression`.
    ///
    /// - parameter expression: Expression with optional `UIView`, `UILayoutGuide` or `NSLayoutXAxisAnchor`,
    ///     no multiplier.
    @discardableResult
    public func trailing<Expression: ParameterExpression>(_ expression: Expression) -> NextChain
        where Expression.Parameter.Item: XAxisItem, Expression.Parameter: BasicParameterProtocol {
            return solve(expression) { $0.trailingAnchor }
    }

    /// Match width to superview.
    @discardableResult
    public func width() -> NextChain {
        return width(BasicParameter<View>(item: item.superview!))
    }

    /// Match width to `expression`.
    ///
    /// - parameter expression: Expression with optional `UIView`, `UILayoutGuide` or `NSLayoutDimension`,
    ///     optional multiplier.
    @discardableResult
    public func width<Expression: ParameterExpression>(_ expression: Expression) -> NextChain
        where Expression.Parameter.Item: DimensionItem {
            return solve(expression) { $0.widthAnchor }
    }

    /// Match height to superview.
    @discardableResult
    public func height() -> NextChain {
        return height(BasicParameter<View>(item: item.superview!))
    }

    /// Match height to `expression`.
    ///
    /// - parameter expression: Expression with optional `UIView`, `UILayoutGuide` or `NSLayoutDimension`,
    ///     optional multiplier.
    @discardableResult
    public func height<Expression: ParameterExpression>(_ expression: Expression) -> NextChain
        where Expression.Parameter.Item: DimensionItem {
            return solve(expression) { $0.heightAnchor }
    }

    /// Align centerX to superview.
    @discardableResult
    public func centerX() -> NextChain {
        return centerX(BasicParameter<View>())
    }

    /// Align centerX to `expression`.
    ///
    /// - parameter expression: Expression with optional `UIView`, `UILayoutGuide` or `NSLayoutXAxisAnchor`,
    ///     no multiplier.
    @discardableResult
    public func centerX<Expression: ParameterExpression>(_ expression: Expression) -> NextChain
        where Expression.Parameter.Item: XAxisItem, Expression.Parameter: BasicParameterProtocol {
            return solve(expression) { $0.centerXAnchor }
    }

    /// Align centerY to superview.
    @discardableResult
    public func centerY() -> NextChain {
        return centerY(BasicParameter<View>())
    }

    /// Align centerY to `expression`.
    ///
    /// - parameter expression: Expression with optional `UIView`, `UILayoutGuide` or `NSLayoutYAxisAnchor`,
    ///     no multiplier.
    @discardableResult
    public func centerY<Expression: ParameterExpression>(_ expression: Expression) -> NextChain
        where Expression.Parameter.Item: YAxisItem, Expression.Parameter: BasicParameterProtocol {
            return solve(expression) { $0.centerYAnchor }
    }

    /// Pin firstBaseline to superview.
    @discardableResult
    public func firstBaseline() -> NextChain {
        return firstBaseline(BasicParameter<View>())
    }

    /// Pin firstBaseline to `expression`.
    ///
    /// - parameter expression: Expression with optional `UIView`, `UILayoutGuide` or `NSLayoutYAxisAnchor`,
    ///     no multiplier.
    @discardableResult
    public func firstBaseline<Expression: ParameterExpression>(_ expression: Expression) -> NextChain
        where Expression.Parameter.Item: YAxisItem, Expression.Parameter: BasicParameterProtocol {
            return solve(expression) { $0.firstBaselineAnchor }
    }

    /// Pin lastBaseline to superview.
    @discardableResult
    public func lastBaseline() -> NextChain {
        return lastBaseline(BasicParameter<View>())
    }

    /// Pin lastBaseline to `expression`.
    ///
    /// - parameter expression: Expression with optional `UIView`, `UILayoutGuide` or `NSLayoutYAxisAnchor`,
    ///     no multiplier.
    @discardableResult
    public func lastBaseline<Expression: ParameterExpression>(_ expression: Expression) -> NextChain
        where Expression.Parameter.Item: YAxisItem, Expression.Parameter: BasicParameterProtocol {
            return solve(expression) { $0.lastBaselineAnchor }
    }

    /// Set aspect ratio.
    ///
    /// - parameter ratio: Aspect ratio, defaults to 1.
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
