//
//  LayoutFill.swift
//  Bamboo
//
//  Created by Javier on 12/6/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import Foundation

extension LayoutChain {
    @discardableResult
    public func fill(insets: EdgeInsets = EdgeInsets()) -> LayoutChain {
        return fillWidth(insets: insets).fillHeight(insets: insets)
    }

    @discardableResult
    public func fillLeft(width: CGFloat, insets: EdgeInsets = EdgeInsets()) -> LayoutChain {
        return fillHeight(insets: insets).width(width).left(inset: insets.left)
    }

    @discardableResult
    public func fillRight(width: CGFloat, insets: EdgeInsets = EdgeInsets()) -> LayoutChain {
        return fillHeight(insets: insets).width(width).right(inset: insets.right)
    }

    @discardableResult
    public func fillTop(height: CGFloat, insets: EdgeInsets = EdgeInsets()) -> LayoutChain {
        return fillWidth(insets: insets).height(height).top(inset: insets.top)
    }

    @discardableResult
    public func fillBottom(height: CGFloat, insets: EdgeInsets = EdgeInsets()) -> LayoutChain {
        return fillWidth(insets: insets).height(height).bottom(inset: insets.bottom)
    }

    @discardableResult
    public func fillWidth(insets: EdgeInsets = EdgeInsets()) -> LayoutChain {
        return width(superSize.width - insets.left - insets.right).left(insets.left)
    }

    @discardableResult
    public func fillHeight(insets: EdgeInsets = EdgeInsets()) -> LayoutChain {
        return height(superSize.height - insets.top - insets.bottom).top(insets.top)
    }
}
