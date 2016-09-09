//
//  FrameProtocol.swift
//  eleLayout
//
//  Created by Javier on 8/22/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import Foundation

public protocol FrameProtocol: class, EdgeProtocol {
    var bounds: CGRect { get set }
    var center: CGPoint { get set }
}

extension FrameProtocol {
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

    @discardableResult
    public func setSize(_ size: CGSize) -> Self {
        self.size = size
        return self
    }

    @discardableResult
    public func setWidth(_ width: CGFloat) -> Self {
        size.width = width
        return self
    }

    @discardableResult
    public func setHeight(_ height: CGFloat) -> Self {
        size.height = height
        return self
    }

    @discardableResult
    public func setCenter(_ center: CGPoint) -> Self {
        self.center = center
        return self
    }

    @discardableResult
    public func setCenterX(_ centerX: CGFloat) -> Self {
        center.x = centerX
        return self
    }

    @discardableResult
    public func setCenterY(_ centerY: CGFloat) -> Self {
        center.y = centerY
        return self
    }

    @discardableResult
    public func matchWidthToHeight(multiplier: CGFloat = 1, offset: CGFloat = 0) -> Self {
        return setWidth((multiplier * size.height).rounded() + offset)
    }

    @discardableResult
    public func matchHeightToWidth(multiplier: CGFloat = 1, offset: CGFloat = 0) -> Self {
        return setHeight((multiplier * size.width).rounded() + offset)
    }

    public func axis(_ axis: LayoutAxis) -> CGFloat {
        switch axis {
        case .left: return left
        case .right: return right
        case .top: return top
        case .bottom: return bottom
        case .centerX: return center.x
        case .centerY: return center.y
        }
    }

    @discardableResult
    public func setAxis(_ axis: LayoutAxis, value: CGFloat) -> Self {
        switch axis {
        case .left: left = value
        case .right: right = value
        case .top: top = value
        case .bottom: bottom = value
        case .centerX: center.x = value
        case .centerY: center.y = value
        }
        
        return self
    }
}

#if os(iOS)
    extension UICollectionViewLayoutAttributes: FrameProtocol {}
#endif
