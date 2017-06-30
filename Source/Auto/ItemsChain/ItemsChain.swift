//
//  ItemsChain.swift
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

public protocol ItemsConstraintChain {
    associatedtype Item: ConstraintItem

    /// Items to be constrained.
    var items: [Item] { get }

    /// All constraints accumulated in a chain.
    var constraints: [NSLayoutConstraint] { get }
}

extension ItemsConstraintChain {
    /// Add constraints in `chains`.
    func add<Chain: ConstraintChain>(_ chains: [Chain]) -> ItemsChain<Item> {
        let c = chains.flatMap { $0.constraints }
        return ItemsChain(items: items, constraints: constraints + c)
    }
}

/// Chain with multiple items.
public struct ItemsChain<Item: ConstraintItem>: ItemsConstraintChain {
    public var items: [Item]
    public var constraints: [NSLayoutConstraint]

    init(items: [Item], constraints: [NSLayoutConstraint] = []) {
        self.items = items
        self.constraints = constraints
    }
}

extension Array where Element: ConstraintItem {
    /// Start a constraint chain.
    public var constrain: ItemsChain<Element> {
        return ItemsChain(items: self)
    }
}
