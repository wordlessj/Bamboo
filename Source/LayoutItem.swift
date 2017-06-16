//
//  LayoutItem.swift
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

public protocol LayoutItem: class {
    var bounds: CGRect { get set }
    var center: CGPoint { get set }
    var superItem: LayoutItem? { get }
}

extension LayoutItem {
    public var layout: LayoutChain<Self> { return LayoutChain(item: self) }

    public var size: CGSize {
        get { return bounds.size }
        set { bounds.size = newValue }
    }

    public var left: CGFloat {
        get { return center.x - size.width / 2 }
        set { center.x = newValue + size.width / 2 }
    }

    public var right: CGFloat {
        get { return center.x + size.width / 2 }
        set { center.x = newValue - size.width / 2 }
    }

    public var top: CGFloat {
        get { return center.y - size.height / 2 }
        set { center.y = newValue + size.height / 2 }
    }

    public var bottom: CGFloat {
        get { return center.y + size.height / 2 }
        set { center.y = newValue - size.height / 2 }
    }
}

extension CALayer: LayoutItem {
    public var center: CGPoint {
        get { return position }
        set { position = newValue }
    }

    public var superItem: LayoutItem? { return superlayer }
}

extension View: LayoutItem {
    public var superItem: LayoutItem? { return superview }

    #if os(OSX)
        public var center: CGPoint {
            get { return CGPoint(x: frame.midX, y: frame.midY) }
            set { setFrameOrigin(CGPoint(x: newValue.x - frame.width / 2, y: newValue.y - frame.height / 2)) }
        }
    #endif
}
