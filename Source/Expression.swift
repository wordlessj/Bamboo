//
//  Expression.swift
//  Bamboo
//
//  Created by Javier on 10/27/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import Foundation

public protocol XAxisItem {}
public protocol YAxisItem {}
public protocol DimensionItem {}

extension NSLayoutXAxisAnchor: XAxisItem {}
extension NSLayoutYAxisAnchor: YAxisItem {}
extension NSLayoutDimension: DimensionItem {}

public protocol ParameterProtocol {
    associatedtype Item
    var item: Item? { get set }
    var constant: CGFloat { get set }
    var relation: NSLayoutRelation { get set }
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

public protocol BasicParameterProtocol: ParameterProtocol {}

public struct BasicParameter<Item>: BasicParameterProtocol {
    public var item: Item?
    public var constant: CGFloat = 0
    public var relation: NSLayoutRelation = .equal
    public var priority: LayoutPriority = LayoutPriorityRequired

    init() {}
    init(item: Item?) { self.item = item }
    init(constant: CGFloat) { self.constant = constant }

    public func multiplied(_ multiplier: CGFloat) -> MultiplierParameter<Item> {
        return MultiplierParameter(self, multiplier: multiplier)
    }
}

public protocol MultiplierParameterProtocol: ParameterProtocol {
    var multiplier: CGFloat { get set }
}

public struct MultiplierParameter<Item>: MultiplierParameterProtocol {
    public var item: Item?
    public var constant: CGFloat = 0
    public var relation: NSLayoutRelation = .equal
    public var priority: LayoutPriority = LayoutPriorityRequired
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

#if os(iOS)
    extension UILayoutGuide: ParameterExpression {
        public var constraintParameter: BasicParameter<UILayoutGuide> {
            return BasicParameter(item: self)
        }
    }
#endif
