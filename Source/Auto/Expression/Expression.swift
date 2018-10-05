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
    associatedtype MultipliedParameter
    associatedtype AddedParameter

    var item: Item? { get set }
    var relation: NSLayoutConstraint.Relation { get set }
    var priority: LayoutPriority { get set }
    var optionalMultiplier: CGFloat? { get }
    var optionalConstant: CGFloat? { get }

    func multiplied(_ multiplier: CGFloat) -> MultipliedParameter
    func added(_ constant: CGFloat) -> AddedParameter
}

extension ParameterProtocol {
    func modified(_ modify: (inout Self) -> ()) -> Self {
        var parameter = self
        modify(&parameter)
        return parameter
    }
}

/// Parameters without multiplier or constant.
public struct BasicParameter<Item>: ParameterProtocol {
    public var item: Item?
    public var relation: NSLayoutConstraint.Relation = .equal
    public var priority: LayoutPriority = .required

    public var optionalMultiplier: CGFloat? { return nil }
    public var optionalConstant: CGFloat? { return nil }

    init() {}
    init(item: Item?) { self.item = item }

    public func multiplied(_ multiplier: CGFloat) -> MultiplierParameter<Item> {
        return MultiplierParameter(self, multiplier: multiplier)
    }

    public func added(_ constant: CGFloat) -> ConstantParameter<Item> {
        return ConstantParameter(self, constant: constant)
    }
}

/// Parameters with multiplier.
public struct MultiplierParameter<Item>: ParameterProtocol {
    public var item: Item?
    public var relation: NSLayoutConstraint.Relation = .equal
    public var priority: LayoutPriority = .required
    public var multiplier: CGFloat = 1

    public var optionalMultiplier: CGFloat? { return multiplier }
    public var optionalConstant: CGFloat? { return nil }

    init(_ parameter: BasicParameter<Item>, multiplier: CGFloat) {
        item = parameter.item
        relation = parameter.relation
        priority = parameter.priority
        self.multiplier = multiplier
    }

    public func multiplied(_ multiplier: CGFloat) -> MultiplierParameter<Item> {
        return modified { $0.multiplier *= multiplier }
    }

    public func added(_ constant: CGFloat) -> FullParameter<Item> {
        return FullParameter(self, constant: constant)
    }
}

/// Parameters with constant.
public struct ConstantParameter<Item>: ParameterProtocol {
    public var item: Item?
    public var relation: NSLayoutConstraint.Relation = .equal
    public var priority: LayoutPriority = .required
    public var constant: CGFloat = 0

    public var optionalMultiplier: CGFloat? { return nil }
    public var optionalConstant: CGFloat? { return constant }

    init(constant: CGFloat) { self.constant = constant }

    init(_ parameter: BasicParameter<Item>, constant: CGFloat) {
        item = parameter.item
        relation = parameter.relation
        priority = parameter.priority
        self.constant = constant
    }

    public func multiplied(_ multiplier: CGFloat) -> FullParameter<Item> {
        return FullParameter(self, multiplier: multiplier)
    }

    public func added(_ constant: CGFloat) -> ConstantParameter<Item> {
        return modified { $0.constant += constant }
    }
}

/// Parameters with multiplier and constant.
public struct FullParameter<Item>: ParameterProtocol {
    public var item: Item?
    public var relation: NSLayoutConstraint.Relation = .equal
    public var priority: LayoutPriority = .required
    public var multiplier: CGFloat = 1
    public var constant: CGFloat = 0

    public var optionalMultiplier: CGFloat? { return multiplier }
    public var optionalConstant: CGFloat? { return constant }

    init(_ parameter: ConstantParameter<Item>, multiplier: CGFloat) {
        item = parameter.item
        relation = parameter.relation
        priority = parameter.priority
        constant = parameter.constant * multiplier
        self.multiplier = multiplier
    }

    init(_ parameter: MultiplierParameter<Item>, constant: CGFloat) {
        item = parameter.item
        relation = parameter.relation
        priority = parameter.priority
        multiplier = parameter.multiplier
        self.constant = constant
    }

    public func multiplied(_ multiplier: CGFloat) -> FullParameter<Item> {
        return modified {
            $0.multiplier *= multiplier
            $0.constant *= multiplier
        }
    }

    public func added(_ constant: CGFloat) -> FullParameter<Item> {
        return modified { $0.constant += constant }
    }
}

/// Parameters with system spacing.
public struct SystemSpacingParameter<Item>: ParameterProtocol {
    public var item: Item?
    public var relation: NSLayoutConstraint.Relation = .equal
    public var priority: LayoutPriority = .required
    public var multiplier: CGFloat = 1

    public var optionalMultiplier: CGFloat? { return multiplier }
    public var optionalConstant: CGFloat? { return nil }

    init<P: ParameterProtocol>(_ parameter: P, multiplier: CGFloat)
        where P: SystemSpacingParameterConvertible, P.Item == Item {
            item = parameter.item
            relation = parameter.relation
            priority = parameter.priority
            self.multiplier = multiplier
    }

    public func multiplied(_ multiplier: CGFloat) -> SystemSpacingParameter<Item> {
        return modified { $0.multiplier *= multiplier }
    }

    public func added(_ constant: CGFloat) -> () {
        return ()
    }
}

/// Parameters for axis, used as a type constraint in expressions.
public protocol AxisParameterProtocol {}

/// Parameters for dimension, used as a type constraint in expressions.
public protocol DimensionParameterProtocol {}

/// Parameters which can be converted to `SystemSpacingParameter`.
public protocol SystemSpacingParameterConvertible {}

/// Parameters with system spacing.
public protocol SystemSpacingParameterProtocol {}

extension BasicParameter: AxisParameterProtocol, DimensionParameterProtocol, SystemSpacingParameterConvertible {}
extension MultiplierParameter: DimensionParameterProtocol {}
extension ConstantParameter: AxisParameterProtocol, DimensionParameterProtocol {}
extension FullParameter: DimensionParameterProtocol {}
extension SystemSpacingParameter: AxisParameterProtocol, SystemSpacingParameterProtocol {}

/// Full form of an expression:
///
/// `( >= or <= ) item * multiplier + constant ~ priority`
///
/// `item` can be `UIView`, `UILayoutGuide` or `NSLayoutAnchor`.
/// Instead of using `*` and `+`, you can use `/` and `-`.
public protocol ParameterExpression {
    associatedtype Parameter: ParameterProtocol
    var bb_parameter: Parameter { get }
}

extension BasicParameter: ParameterExpression {
    public var bb_parameter: BasicParameter { return self }
}

extension MultiplierParameter: ParameterExpression {
    public var bb_parameter: MultiplierParameter { return self }
}

extension ConstantParameter: ParameterExpression {
    public var bb_parameter: ConstantParameter { return self }
}

extension FullParameter: ParameterExpression {
    public var bb_parameter: FullParameter { return self }
}

extension SystemSpacingParameter: ParameterExpression {
    public var bb_parameter: SystemSpacingParameter { return self }
}

extension Int: ParameterExpression {
    public var bb_parameter: ConstantParameter<View> {
        return ConstantParameter(constant: CGFloat(self))
    }
}

extension Double: ParameterExpression {
    public var bb_parameter: ConstantParameter<View> {
        return ConstantParameter(constant: CGFloat(self))
    }
}

extension CGFloat: ParameterExpression {
    public var bb_parameter: ConstantParameter<View> {
        return ConstantParameter(constant: self)
    }
}

extension View: ParameterExpression {
    public var bb_parameter: BasicParameter<View> {
        return BasicParameter(item: self)
    }
}

extension NSLayoutXAxisAnchor: ParameterExpression {
    public var bb_parameter: BasicParameter<NSLayoutXAxisAnchor> {
        return BasicParameter(item: self)
    }
}

extension NSLayoutYAxisAnchor: ParameterExpression {
    public var bb_parameter: BasicParameter<NSLayoutYAxisAnchor> {
        return BasicParameter(item: self)
    }
}

extension NSLayoutDimension: ParameterExpression {
    public var bb_parameter: BasicParameter<NSLayoutDimension> {
        return BasicParameter(item: self)
    }
}

#if os(iOS) || os(tvOS)
    extension UILayoutGuide: ParameterExpression {
        public var bb_parameter: BasicParameter<UILayoutGuide> {
            return BasicParameter(item: self)
        }
    }
#endif
