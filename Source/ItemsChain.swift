//
//  ItemsChain.swift
//  Bamboo
//
//  Created by Javier on 10/7/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import Foundation

public protocol ItemsConstraintChain: ConstraintsContainer {
    associatedtype Item: ConstraintItem
    var items: [Item] { get }
}

extension ItemsConstraintChain {
    func add<Container: ConstraintsContainer>(_ containers: [Container]) -> ItemsChain<Item> {
        let c = containers.flatMap { $0.constraints }
        return ItemsChain(items: items, constraints: constraints + c)
    }

    func merge<Container: ConstraintsContainer>(_ containers: [Container]) -> ItemsChain<Item> {
        return ItemsChain(items: items, constraints: merge(containers))
    }
}

public struct ItemsChain<Item: ConstraintItem>: ItemsConstraintChain {
    public var items: [Item]
    public var constraints: [NSLayoutConstraint]

    init(items: [Item], constraints: [NSLayoutConstraint] = []) {
        self.items = items
        self.constraints = constraints
    }
}

extension Array where Element: ConstraintItem {
    public var constrain: ItemsChain<Element> {
        return ItemsChain(items: self)
    }
}
