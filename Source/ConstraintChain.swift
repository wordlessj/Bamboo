//
//  ConstraintChain.swift
//  Bamboo
//
//  Created by Javier on 8/22/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import Foundation

public protocol ConstraintsContainer {
    var constraints: [NSLayoutConstraint] { get }
}

extension ConstraintsContainer {
    func merge<Container: ConstraintsContainer>(_ containers: [Container]) -> [NSLayoutConstraint] {
        return constraints + containers.flatMap { $0.constraints.dropFirst(constraints.count) }
    }
}

public protocol ConstraintChainBase: ConstraintsContainer {
    associatedtype Item: ConstraintItem
    var item: Item { get }
}

public protocol ConstraintChain: ConstraintChainBase {
    associatedtype NextChain: ConstraintChainBase
    func nextChain(_ c: NSLayoutConstraint) -> NextChain
}

extension ConstraintChain {
    func merge<Container: ConstraintsContainer>(_ containers: [Container]) -> MultipleChain<Item> {
        return MultipleChain(item: item, constraints: merge(containers))
    }
}

public struct InitialChain<Item: ConstraintItem>: ConstraintChain {
    public var item: Item
    public var constraints: [NSLayoutConstraint]

    init(item: Item) {
        self.item = item
        constraints = []
    }

    public func nextChain(_ c: NSLayoutConstraint) -> SingleChain<Item> {
        return SingleChain(item: item, constraint: c)
    }
}

public struct SingleChain<Item: ConstraintItem>: ConstraintChain {
    public var item: Item
    public var constraint: NSLayoutConstraint

    public var constraints: [NSLayoutConstraint] { return [constraint] }

    public func nextChain(_ c: NSLayoutConstraint) -> MultipleChain<Item> {
        return MultipleChain(item: item, constraints: [constraint, c])
    }
}

public struct MultipleChain<Item: ConstraintItem>: ConstraintChain {
    public var item: Item
    public var constraints: [NSLayoutConstraint]

    public func nextChain(_ c: NSLayoutConstraint) -> MultipleChain<Item> {
        return MultipleChain(item: item, constraints: constraints + [c])
    }
}
