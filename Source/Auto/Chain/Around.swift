//
//  Around.swift
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
    /// Pin trailing to `item`'s leading with `spacing`.
    ///
    /// - parameters:
    ///     - item: `UIView` or `UILayoutGuide`, if `nil`, it'll be superview.
    ///     - spacing: Spacing between `self` and `item`.
    @discardableResult
    public func before(_ item: ConstraintItem? = nil, spacing: CGFloat = 0) -> NextChain {
        let p = parameter(item) { $0.leadingAnchor }
        return trailing(p - spacing)
    }

    /// Pin leading to `item`'s trailing with `spacing`.
    ///
    /// - parameters:
    ///     - item: `UIView` or `UILayoutGuide`, if `nil`, it'll be superview.
    ///     - spacing: Spacing between `self` and `item`.
    @discardableResult
    public func after(_ item: ConstraintItem? = nil, spacing: CGFloat = 0) -> NextChain {
        let p = parameter(item) { $0.trailingAnchor }
        return leading(p + spacing)
    }

    /// Pin bottom to `item`'s top with `spacing`.
    ///
    /// - parameters:
    ///     - item: `UIView` or `UILayoutGuide`, if `nil`, it'll be superview.
    ///     - spacing: Spacing between `self` and `item`.
    @discardableResult
    public func above(_ item: ConstraintItem? = nil, spacing: CGFloat = 0) -> NextChain {
        let p = parameter(item) { $0.topAnchor }
        return bottom(p - spacing)
    }

    /// Pin top to `item`'s bottom with `spacing`.
    ///
    /// - parameters:
    ///     - item: `UIView` or `UILayoutGuide`, if `nil`, it'll be superview.
    ///     - spacing: Spacing between `self` and `item`.
    @discardableResult
    public func below(_ item: ConstraintItem? = nil, spacing: CGFloat = 0) -> NextChain {
        let p = parameter(item) { $0.bottomAnchor }
        return top(p + spacing)
    }

    private func parameter<Anchor>(
        _ parameterItem: ConstraintItem?,
        anchorOf: (ConstraintItem) -> Anchor
    ) -> BasicParameter<Anchor> {
        return BasicParameter(item: anchorOf(parameterItem ?? item.bb_superview!))
    }
}
