//
//  ConstraintItem.swift
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

/// Item which has `bb` extensions, namely `UIView` and `UILayoutGuide`.
public protocol ConstraintItem: XAxisItem, YAxisItem, DimensionItem {
    var bb_superview: View? { get }

    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }

    var bb_firstBaselineAnchor: NSLayoutYAxisAnchor { get }
    var bb_lastBaselineAnchor: NSLayoutYAxisAnchor { get }
}

extension ConstraintItem {
    /// Start an auto layout chain.
    public var bb: InitialChain<Self> {
        return InitialChain(item: self)
    }

    @available(*, deprecated, renamed: "bb")
    public var constrain: InitialChain<Self> {
        return bb
    }
}

extension View: ConstraintItem {
    public var bb_superview: View? { return superview }

    public var bb_firstBaselineAnchor: NSLayoutYAxisAnchor { return firstBaselineAnchor }
    public var bb_lastBaselineAnchor: NSLayoutYAxisAnchor { return lastBaselineAnchor }
}

#if os(iOS) || os(tvOS)
extension UILayoutGuide: ConstraintItem {
    public var bb_superview: View? { return owningView }

    public var bb_firstBaselineAnchor: NSLayoutYAxisAnchor { return topAnchor }
    public var bb_lastBaselineAnchor: NSLayoutYAxisAnchor { return bottomAnchor }
}
#endif
