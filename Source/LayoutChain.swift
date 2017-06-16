//
//  LayoutChain.swift
//  Bamboo
//
//  Created by Javier on 12/6/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import Foundation

public struct LayoutChain<Item: LayoutItem> {
    let item: Item
}

extension LayoutChain {
    @discardableResult
    public func left(_ value: CGFloat) -> LayoutChain {
        item.left = value
        return self
    }

    @discardableResult
    public func right(_ value: CGFloat) -> LayoutChain {
        item.right = value
        return self
    }

    @discardableResult
    public func top(_ value: CGFloat) -> LayoutChain {
        item.top = value
        return self
    }

    @discardableResult
    public func bottom(_ value: CGFloat) -> LayoutChain {
        item.bottom = value
        return self
    }

    @discardableResult
    public func width(_ value: CGFloat) -> LayoutChain {
        item.size.width = value
        return self
    }

    @discardableResult
    public func height(_ value: CGFloat) -> LayoutChain {
        item.size.height = value
        return self
    }

    @discardableResult
    public func size(_ value: CGSize) -> LayoutChain {
        item.size = value
        return self
    }

    @discardableResult
    public func centerX(_ value: CGFloat) -> LayoutChain {
        item.center.x = value
        return self
    }

    @discardableResult
    public func centerY(_ value: CGFloat) -> LayoutChain {
        item.center.y = value
        return self
    }

    @discardableResult
    public func center(_ value: CGPoint) -> LayoutChain {
        item.center = value
        return self
    }

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
