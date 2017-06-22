//
//  ItemsSize.swift
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
    @discardableResult
    public func width(_ w: CGFloat) -> ItemsChain<Item> {
        return each { $0.constrain.width(w) }
    }

    @discardableResult
    public func height(_ h: CGFloat) -> ItemsChain<Item> {
        return each { $0.constrain.height(h) }
    }

    @discardableResult
    public func size() -> ItemsChain<Item> {
        return width().height()
    }

    @discardableResult
    public func size(_ s: CGFloat) -> ItemsChain<Item> {
        return size(width: s, height: s)
    }

    @discardableResult
    public func size(_ cgSize: CGSize) -> ItemsChain<Item> {
        return size(width: cgSize.width, height: cgSize.height)
    }

    @discardableResult
    public func size(width w: CGFloat, height h: CGFloat) -> ItemsChain<Item> {
        return each { $0.constrain.size(width: w, height: h) }
    }
}
