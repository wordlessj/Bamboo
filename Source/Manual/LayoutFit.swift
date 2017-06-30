//
//  LayoutFit.swift
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

public protocol FittingSizeContainer {
    var fittingSize: CGSize { get }
}

#if os(iOS) || os(tvOS)
    extension UIView: FittingSizeContainer {
        public var fittingSize: CGSize { return sizeThatFits(layout.superSize) }
    }
#endif

extension LayoutChain where Item: FittingSizeContainer {
    /// Set size to the result of `sizeThatFits()`.
    @discardableResult
    public func fitSize() -> LayoutChain {
        return size(item.fittingSize)
    }

    /// Set width to the result of `sizeThatFits()`.
    @discardableResult
    public func fitWidth() -> LayoutChain {
        return width(item.fittingSize.width)
    }

    /// Set height to the result of `sizeThatFits()`.
    @discardableResult
    public func fitHeight() -> LayoutChain {
        return height(item.fittingSize.height)
    }
}
