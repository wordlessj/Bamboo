//
//  ConstraintChain.swift
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

/// Extracted from `ConstraintChain` in order to circumvent self constraint on `associatedtype`.
public protocol ConstraintChainBase {
    associatedtype Item: ConstraintItem

    /// Item to be constrained.
    var item: Item { get }

    /// All constraints accumulated in a chain.
    var constraints: [NSLayoutConstraint] { get }
}

public protocol ConstraintChain: ConstraintChainBase {
    /// Next chain based on current number of constraints when appended with one constraint.
    /// Returns `SingleChain` when there is no constraints and `MultipleChain` when there is one constraint at least.
    associatedtype NextChain: ConstraintChainBase

    /// Next chain appended with a constraint.
    func nextChain(_ c: NSLayoutConstraint) -> NextChain
}

extension ConstraintChain {
    /// Converted to `MultipleChain` in order to use chaining style on general chain.
    var toMultipleChain: MultipleChain<Item> {
        return MultipleChain(item: item, constraints: constraints)
    }
}

/// Chain created from `bb` with no constraints.
public struct InitialChain<Item: ConstraintItem>: ConstraintChain {
    public var item: Item
    public var constraints: [NSLayoutConstraint] { return [] }

    public func nextChain(_ c: NSLayoutConstraint) -> SingleChain<Item> {
        return SingleChain(item: item, constraint: c)
    }
}

/// Chain with one constraint.
public struct SingleChain<Item: ConstraintItem>: ConstraintChain {
    public var item: Item

    /// Constraint created from last call.
    public var constraint: NSLayoutConstraint

    public var constraints: [NSLayoutConstraint] { return [constraint] }

    public func nextChain(_ c: NSLayoutConstraint) -> MultipleChain<Item> {
        return MultipleChain(item: item, constraints: [constraint, c])
    }
}

/// Chain with more than one constraint.
public struct MultipleChain<Item: ConstraintItem>: ConstraintChain {
    public var item: Item
    public var constraints: [NSLayoutConstraint]

    public func nextChain(_ c: NSLayoutConstraint) -> MultipleChain<Item> {
        return MultipleChain(item: item, constraints: constraints + [c])
    }
}
