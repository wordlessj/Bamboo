//
//  LayoutFill.swift
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
    /// Fill superview/layer with `insets`.
    @discardableResult
    public func fill(insets: EdgeInsets = EdgeInsets()) -> LayoutChain {
        return fillWidth(insets: insets).fillHeight(insets: insets)
    }

    /// Fill left of superview/layer with `insets` and set width.
    @discardableResult
    public func fillLeft(width: CGFloat, insets: EdgeInsets = EdgeInsets()) -> LayoutChain {
        return fillHeight(insets: insets).width(width).left(inset: insets.left)
    }

    /// Fill right of superview/layer with `insets` and set width.
    @discardableResult
    public func fillRight(width: CGFloat, insets: EdgeInsets = EdgeInsets()) -> LayoutChain {
        return fillHeight(insets: insets).width(width).right(inset: insets.right)
    }

    /// Fill top of superview/layer with `insets` and set height.
    @discardableResult
    public func fillTop(height: CGFloat, insets: EdgeInsets = EdgeInsets()) -> LayoutChain {
        return fillWidth(insets: insets).height(height).top(inset: insets.top)
    }

    /// Fill bottom of superview/layer with `insets` and set height.
    @discardableResult
    public func fillBottom(height: CGFloat, insets: EdgeInsets = EdgeInsets()) -> LayoutChain {
        return fillWidth(insets: insets).height(height).bottom(inset: insets.bottom)
    }

    /// Fill width of superview/layer with `insets`.
    @discardableResult
    public func fillWidth(insets: EdgeInsets = EdgeInsets()) -> LayoutChain {
        return width(superSize.width - insets.left - insets.right).left(insets.left)
    }

    /// Fill height of superview/layer with `insets`.
    @discardableResult
    public func fillHeight(insets: EdgeInsets = EdgeInsets()) -> LayoutChain {
        return height(superSize.height - insets.top - insets.bottom).top(insets.top)
    }
}
