//
//  Fill.swift
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
    @discardableResult
    public func fill(insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fill(Optional<View>.none, insets: insets)
    }

    @discardableResult
    public func fill<CI: ConstraintItem>(_ item: CI?, insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fill(nil, of: item, insets: insets)
    }

    @discardableResult
    public func fillLeft(insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fillLeft(Optional<View>.none, insets: insets)
    }

    @discardableResult
    public func fillLeft<CI: ConstraintItem>(_ item: CI?, insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fill(.left, of: item, insets: insets)
    }

    @discardableResult
    public func fillRight(insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fillRight(Optional<View>.none, insets: insets)
    }

    @discardableResult
    public func fillRight<CI: ConstraintItem>(_ item: CI?, insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fill(.right, of: item, insets: insets)
    }

    @discardableResult
    public func fillTop(insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fillTop(Optional<View>.none, insets: insets)
    }

    @discardableResult
    public func fillTop<CI: ConstraintItem>(_ item: CI?, insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fill(.top, of: item, insets: insets)
    }

    @discardableResult
    public func fillBottom(insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fillBottom(Optional<View>.none, insets: insets)
    }

    @discardableResult
    public func fillBottom<CI: ConstraintItem>(_ item: CI?, insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fill(.bottom, of: item, insets: insets)
    }

    @discardableResult
    public func fillLeading(insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fillLeading(Optional<View>.none, insets: insets)
    }

    @discardableResult
    public func fillLeading<CI: ConstraintItem>(_ item: CI?, insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fill(.leading, of: item, insets: insets)
    }

    @discardableResult
    public func fillTrailing(insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fillTrailing(Optional<View>.none, insets: insets)
    }

    @discardableResult
    public func fillTrailing<CI: ConstraintItem>
        (_ item: CI?, insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fill(.trailing, of: item, insets: insets)
    }

    @discardableResult
    public func fillWidth(insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fillWidth(Optional<View>.none, insets: insets)
    }

    @discardableResult
    public func fillWidth<CI: ConstraintItem>(_ item: CI?, insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fill(.width, of: item, insets: insets)
    }

    @discardableResult
    public func fillHeight(insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fillHeight(Optional<View>.none, insets: insets)
    }

    @discardableResult
    public func fillHeight<CI: ConstraintItem>(_ item: CI?, insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fill(.height, of: item, insets: insets)
    }

    private func fill<CI: ConstraintItem>
        (_ attribute: NSLayoutAttribute?, of item: CI?, insets: EdgeInsets) -> MultipleChain<Item> {
        let hasHorizontal = attribute == nil || attribute == .top || attribute == .bottom || attribute == .width
        let hasVertical = attribute == nil || attribute == .left || attribute == .right ||
            attribute == .leading || attribute == .trailing || attribute == .height

        let parameter = BasicParameter(item: item)
        var chain = toMultipleChain

        if attribute == .left {
            chain = chain.left(parameter + insets.left)
        }
        if attribute == .right {
            chain = chain.right(parameter - insets.right)
        }
        if attribute == .top || hasVertical {
            chain = chain.top(parameter + insets.top)
        }
        if attribute == .bottom || hasVertical {
            chain = chain.bottom(parameter - insets.bottom)
        }
        if attribute == .leading || hasHorizontal {
            chain = chain.leading(parameter + insets.left)
        }
        if attribute == .trailing || hasHorizontal {
            chain = chain.trailing(parameter - insets.right)
        }

        return chain
    }
}
