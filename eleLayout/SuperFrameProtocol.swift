//
//  SuperFrameProtocol.swift
//  eleLayout
//
//  Created by Javier on 8/22/16.
//  Copyright © 2016 Javier. All rights reserved.
//

#if os(iOS)
    import UIKit
#else
    import AppKit
#endif

public protocol SuperFrameProtocol: FrameProtocol {
    var superFrame: FrameProtocol? { get }
}

extension SuperFrameProtocol {
    public var superSize: CGSize { return superFrame?.size ?? .zero }
    public var superCenter: CGPoint { return CGPoint(x: superSize.width / 2, y: superSize.height / 2) }

    public func superAxis(axis: LayoutAxis, inset: CGFloat = 0) -> CGFloat {
        switch axis {
        case .left: return inset
        case .right: return superSize.width - inset
        case .top: return inset
        case .bottom: return superSize.height - inset
        case .centerX: return superCenter.x + inset
        case .centerY: return superCenter.y + inset
        }
    }

    public func fillSuper(with insets: EdgeInsets = EdgeInsets()) -> Self {
        return fillSuper(.width, insets: insets).fillSuper(.height, insets: insets)
    }

    public func fillSuper(edge: LayoutEdge, otherSize: CGFloat, insets: EdgeInsets = EdgeInsets()) -> Self {
        switch edge {
        case .left, .right: fillSuper(.height, insets: insets).setWidth(otherSize)
        case .top, .bottom: fillSuper(.width, insets: insets).setHeight(otherSize)
        }

        return pinToSuper(LayoutAxis(edge), inset: insets.edge(edge))
    }

    public func fillSuper(dimension: LayoutDimension, insets: EdgeInsets = EdgeInsets()) -> Self {
        switch dimension {
        case .width:
            size.width = superSize.width - insets.left - insets.right
            left = insets.left
        case .height:
            size.height = superSize.height - insets.top - insets.bottom
            top = insets.top
        }

        return self
    }

    public func pinToSuper(axis: LayoutAxis, with selfAxis: LayoutAxis? = nil, inset: CGFloat = 0) -> Self {
        return setAxis(selfAxis ?? axis, value: superAxis(axis, inset: inset))
    }

    public func centerInSuper() -> Self {
        return setCenter(superCenter)
    }

    public func centerInSuperX(offset offset: CGFloat = 0) -> Self {
        return setCenterX(superCenter.x + offset)
    }

    public func centerInSuperY(offset offset: CGFloat = 0) -> Self {
        return setCenterY(superCenter.y + offset)
    }

    public func matchToSuper(multiplier multiplier: CGFloat = 1) -> Self {
        return matchToSuperWidth(multiplier: multiplier).matchToSuperHeight(multiplier: multiplier)
    }

    public func matchToSuperWidth(multiplier multiplier: CGFloat = 1) -> Self {
        return setWidth(round(multiplier * superSize.width))
    }

    public func matchToSuperHeight(multiplier multiplier: CGFloat = 1) -> Self {
        return setHeight(round(multiplier * superSize.height))
    }
}

extension CALayer: SuperFrameProtocol {
    public var center: CGPoint {
        get { return position }
        set { position = newValue }
    }

    public var superFrame: FrameProtocol? { return superlayer }
}

extension View: SuperFrameProtocol {
    public var superFrame: FrameProtocol? { return superview }

    #if os(OSX)
        public var center: CGPoint {
            get { return CGPoint(x: frame.midX, y: frame.midY) }
            set { setFrameOrigin(CGPoint(x: newValue.x - frame.width / 2, y: newValue.y - frame.height / 2)) }
        }
    #endif
}
