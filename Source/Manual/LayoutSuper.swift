//
//  LayoutSuper.swift
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

extension LayoutChain {
    public var superSize: CGSize { return item.superItem?.size ?? .zero }
    public var superCenter: CGPoint { return CGPoint(x: superSize.width / 2, y: superSize.height / 2) }
    public var superLeft: CGFloat { return 0 }
    public var superRight: CGFloat { return superSize.width }
    public var superTop: CGFloat { return 0 }
    public var superBottom: CGFloat { return superSize.height }

    @discardableResult
    public func left(inset: CGFloat = 0) -> LayoutChain {
        return left(superLeft + inset)
    }

    @discardableResult
    public func right(inset: CGFloat = 0) -> LayoutChain {
        return right(superRight - inset)
    }

    @discardableResult
    public func top(inset: CGFloat = 0) -> LayoutChain {
        return top(superTop + inset)
    }

    @discardableResult
    public func bottom(inset: CGFloat = 0) -> LayoutChain {
        return bottom(superBottom - inset)
    }

    @discardableResult
    public func width(multiplier: CGFloat = 1) -> LayoutChain {
        return width((multiplier * superSize.width).rounded())
    }

    @discardableResult
    public func height(multiplier: CGFloat = 1) -> LayoutChain {
        return height((multiplier * superSize.height).rounded())
    }

    @discardableResult
    public func size(multiplier: CGFloat = 1) -> LayoutChain {
        return width(multiplier: multiplier).height(multiplier: multiplier)
    }

    @discardableResult
    public func centerX(offset: CGFloat = 0) -> LayoutChain {
        return centerX(superCenter.x + offset)
    }

    @discardableResult
    public func centerY(offset: CGFloat = 0) -> LayoutChain {
        return centerY(superCenter.y + offset)
    }

    @discardableResult
    public func center() -> LayoutChain {
        return center(superCenter)
    }
}
