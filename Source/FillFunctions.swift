//
//  FillFunctions.swift
//  Bamboo
//
//  Created by Javier on 10/27/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import Foundation

extension ConstraintChain {
    @discardableResult
    public func fill(insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fill(Optional<View>.none, insets: insets)
    }

    @discardableResult
    public func fill<CI: ConstraintItem>(_ item: CI?, insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fill(nil, of: item, insets: insets)
    }

    @discardableResult
    public func fillLeft(insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fillLeft(Optional<View>.none, insets: insets)
    }

    @discardableResult
    public func fillLeft<CI: ConstraintItem>(_ item: CI?, insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fill(.left, of: item, insets: insets)
    }

    @discardableResult
    public func fillRight(insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fillRight(Optional<View>.none, insets: insets)
    }

    @discardableResult
    public func fillRight<CI: ConstraintItem>(_ item: CI?, insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fill(.right, of: item, insets: insets)
    }

    @discardableResult
    public func fillTop(insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fillTop(Optional<View>.none, insets: insets)
    }

    @discardableResult
    public func fillTop<CI: ConstraintItem>(_ item: CI?, insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fill(.top, of: item, insets: insets)
    }

    @discardableResult
    public func fillBottom(insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fillBottom(Optional<View>.none, insets: insets)
    }

    @discardableResult
    public func fillBottom<CI: ConstraintItem>(_ item: CI?, insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fill(.bottom, of: item, insets: insets)
    }

    @discardableResult
    public func fillLeading(insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fillLeading(Optional<View>.none, insets: insets)
    }

    @discardableResult
    public func fillLeading<CI: ConstraintItem>(_ item: CI?, insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fill(.leading, of: item, insets: insets)
    }

    @discardableResult
    public func fillTrailing(insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fillTrailing(Optional<View>.none, insets: insets)
    }

    @discardableResult
    public func fillTrailing<CI: ConstraintItem>
        (_ item: CI?, insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fill(.trailing, of: item, insets: insets)
    }

    @discardableResult
    public func fillWidth(insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fillWidth(Optional<View>.none, insets: insets)
    }

    @discardableResult
    public func fillWidth<CI: ConstraintItem>(_ item: CI?, insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fill(.width, of: item, insets: insets)
    }

    @discardableResult
    public func fillHeight(insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fillHeight(Optional<View>.none, insets: insets)
    }

    @discardableResult
    public func fillHeight<CI: ConstraintItem>(_ item: CI?, insets: EdgeInsets = EdgeInsets()) -> MultipleChain<Item> {
        return fill(.height, of: item, insets: insets)
    }

    private func fill<CI: ConstraintItem>
        (_ attribute: NSLayoutAttribute?, of item: CI?, insets: EdgeInsets) -> MultipleChain<Item> {
        let hasHorizontal = attribute == nil || attribute == .top || attribute == .bottom || attribute == .width
        let hasVertical = attribute == nil || attribute == .left || attribute == .right ||
            attribute == .leading || attribute == .trailing || attribute == .height

        let parameter = BasicParameter(item: item)
        var chains = [NextChain]()

        if attribute == .left {
            chains.append(left(parameter + insets.left))
        }
        if attribute == .right {
            chains.append(right(parameter - insets.right))
        }
        if attribute == .top || hasVertical {
            chains.append(top(parameter + insets.top))
        }
        if attribute == .bottom || hasVertical {
            chains.append(bottom(parameter - insets.bottom))
        }
        if attribute == .leading || hasHorizontal {
            chains.append(leading(parameter + insets.left))
        }
        if attribute == .trailing || hasHorizontal {
            chains.append(trailing(parameter - insets.right))
        }

        return merge(chains)
    }
}
