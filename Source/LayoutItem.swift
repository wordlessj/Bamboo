//
//  LayoutItem.swift
//  Bamboo
//
//  Created by Javier on 8/22/16.
//  Copyright © 2016 Javier. All rights reserved.
//

#if os(iOS)
    import UIKit
#else
    import AppKit
#endif

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
