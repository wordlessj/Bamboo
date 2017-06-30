//
//  LayoutChain.swift
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

public struct LayoutChain<Item: LayoutItem> {
    let item: Item
}

extension LayoutChain {
    /// Set left value.
    @discardableResult
    public func left(_ value: CGFloat) -> LayoutChain {
        item.left = value
        return self
    }

    /// Set right value.
    @discardableResult
    public func right(_ value: CGFloat) -> LayoutChain {
        item.right = value
        return self
    }

    /// Set top value.
    @discardableResult
    public func top(_ value: CGFloat) -> LayoutChain {
        item.top = value
        return self
    }

    /// Set bottom value.
    @discardableResult
    public func bottom(_ value: CGFloat) -> LayoutChain {
        item.bottom = value
        return self
    }

    /// Set width value.
    @discardableResult
    public func width(_ value: CGFloat) -> LayoutChain {
        item.size.width = value
        return self
    }

    /// Set height value.
    @discardableResult
    public func height(_ value: CGFloat) -> LayoutChain {
        item.size.height = value
        return self
    }

    /// Set size value.
    @discardableResult
    public func size(_ value: CGSize) -> LayoutChain {
        item.size = value
        return self
    }

    /// Set centerX value.
    @discardableResult
    public func centerX(_ value: CGFloat) -> LayoutChain {
        item.center.x = value
        return self
    }

    /// Set centerY value.
    @discardableResult
    public func centerY(_ value: CGFloat) -> LayoutChain {
        item.center.y = value
        return self
    }

    /// Set center value.
    @discardableResult
    public func center(_ value: CGPoint) -> LayoutChain {
        item.center = value
        return self
    }
}
