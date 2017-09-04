//
//  ItemsAttributes.swift
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

extension ItemsConstraintChain {
    /// Align all items' left.
    @discardableResult
    public func left() -> ItemsChain<Item> {
        return attribute { $0.left($1) }
    }

    /// Align all items' right.
    @discardableResult
    public func right() -> ItemsChain<Item> {
        return attribute { $0.right($1) }
    }

    /// Align all items' top.
    @discardableResult
    public func top() -> ItemsChain<Item> {
        return attribute { $0.top($1) }
    }

    /// Align all items' bottom.
    @discardableResult
    public func bottom() -> ItemsChain<Item> {
        return attribute { $0.bottom($1) }
    }

    /// Align all items' leading.
    @discardableResult
    public func leading() -> ItemsChain<Item> {
        return attribute { $0.leading($1) }
    }

    /// Align all items' trailing.
    @discardableResult
    public func trailing() -> ItemsChain<Item> {
        return attribute { $0.trailing($1) }
    }

    /// Match all items' width.
    @discardableResult
    public func width() -> ItemsChain<Item> {
        return attribute { $0.width($1) }
    }

    /// Match all items' height.
    @discardableResult
    public func height() -> ItemsChain<Item> {
        return attribute { $0.height($1) }
    }

    /// Align all items' centerX.
    @discardableResult
    public func centerX() -> ItemsChain<Item> {
        return attribute { $0.centerX($1) }
    }

    /// Align all items' centerY.
    @discardableResult
    public func centerY() -> ItemsChain<Item> {
        return attribute { $0.centerY($1) }
    }

    /// Align all items' firstBaseline.
    @discardableResult
    public func firstBaseline() -> ItemsChain<Item> {
        return attribute { $0.firstBaseline($1) }
    }

    /// Align all items' lastBaseline.
    @discardableResult
    public func lastBaseline() -> ItemsChain<Item> {
        return attribute { $0.lastBaseline($1) }
    }

    private func attribute(
        _ closure: (InitialChain<Item>, BasicParameter<Item>) -> InitialChain<Item>.NextChain
    ) -> ItemsChain<Item> {
        return between { closure($0.bb, BasicParameter(item: $1)) }
    }
}
