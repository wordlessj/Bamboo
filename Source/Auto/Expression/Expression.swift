//
//  Expression.swift
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

/// Item which contains x-axis, used as a type constraint in expressions.
public protocol XAxisItem {}

/// Item which contains y-axis, used as a type constraint in expressions.
public protocol YAxisItem {}

/// Item which contains dimension, used as a type constraint in expressions.
public protocol DimensionItem {}

extension NSLayoutXAxisAnchor: XAxisItem {}
extension NSLayoutYAxisAnchor: YAxisItem {}
extension NSLayoutDimension: DimensionItem {}

/// Parameters constructed from an expression.
public protocol ParameterProtocol {
    associatedtype Item
    var item: Item? { get set }
    var constant: CGFloat { get set }
    var relation: LayoutRelation { get set }
    var priority: LayoutPriority { get set }

    func multiplied(_ multiplier: CGFloat) -> MultiplierParameter<Item>
}

extension ParameterProtocol {
    func modified(_ modify: (inout Self) -> ()) -> Self {
        var parameter = self
        modify(&parameter)
        return parameter
    }
}

/// Used as a type constraint in expressions.
public protocol BasicParameterProtocol: ParameterProtocol {}

/// Parameters without multiplier.
public struct BasicParameter<Item>: BasicParameterProtocol {
    public var item: Item?
    public var constant: CGFloat = 0
    public var relation: LayoutRelation = .equal
    public var priority: LayoutPriority = .required

    init() {}
    init(item: Item?) { self.item = item }
    init(constant: CGFloat) { self.constant = constant }

    public func multiplied(_ multiplier: CGFloat) -> MultiplierParameter<Item> {
        return MultiplierParameter(self, multiplier: multiplier)
    }
}

/// Used as a type constraint in expressions.
public protocol MultiplierParameterProtocol: ParameterProtocol {
    var multiplier: CGFloat { get set }
}

/// Parameters with multiplier.
public struct MultiplierParameter<Item>: MultiplierParameterProtocol {
    public var item: Item?
    public var constant: CGFloat = 0
    public var relation: LayoutRelation = .equal
    public var priority: LayoutPriority = .required
    public var multiplier: CGFloat = 1

    init(_ parameter: BasicParameter<Item>, multiplier: CGFloat) {
        item = parameter.item
        constant = parameter.constant
        relation = parameter.relation
        priority = parameter.priority
        self.multiplier = multiplier
    }

    public func multiplied(_ multiplier: CGFloat) -> MultiplierParameter<Item> {
        return modified {
            $0.multiplier *= multiplier
            $0.constant *= multiplier
        }
    }
}

/// Full form of an expression:
///
/// `( >= or <= ) item * multiplier + constant ~ priority`
///
/// `item` can be `UIView`, `UILayoutGuide` or `NSLayoutAnchor`.
/// Instead of using `*` and `+`, you can use `/` and `-`.
public protocol ParameterExpression {
    associatedtype Parameter: ParameterProtocol
    var constraintParameter: Parameter { get }
}

extension BasicParameter: ParameterExpression {
    public var constraintParameter: BasicParameter { return self }
}

extension MultiplierParameter: ParameterExpression {
    public var constraintParameter: MultiplierParameter { return self }
}

extension Int: ParameterExpression {
    public var constraintParameter: BasicParameter<View> {
        return BasicParameter(constant: CGFloat(self))
    }
}

extension Double: ParameterExpression {
    public var constraintParameter: BasicParameter<View> {
        return BasicParameter(constant: CGFloat(self))
    }
}

extension CGFloat: ParameterExpression {
    public var constraintParameter: BasicParameter<View> {
        return BasicParameter(constant: self)
    }
}

extension View: ParameterExpression {
    public var constraintParameter: BasicParameter<View> {
        return BasicParameter(item: self)
    }
}

extension NSLayoutXAxisAnchor: ParameterExpression {
    public var constraintParameter: BasicParameter<NSLayoutXAxisAnchor> {
        return BasicParameter(item: self)
    }
}

extension NSLayoutYAxisAnchor: ParameterExpression {
    public var constraintParameter: BasicParameter<NSLayoutYAxisAnchor> {
        return BasicParameter(item: self)
    }
}

extension NSLayoutDimension: ParameterExpression {
    public var constraintParameter: BasicParameter<NSLayoutDimension> {
        return BasicParameter(item: self)
    }
}

#if os(iOS) || os(tvOS)
    extension UILayoutGuide: ParameterExpression {
        public var constraintParameter: BasicParameter<UILayoutGuide> {
            return BasicParameter(item: self)
        }
    }
#endif
