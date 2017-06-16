//
//  ItemsSizeFunctions.swift
//  Bamboo
//
//  Created by Javier on 10/28/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import Foundation

extension ItemsConstraintChain {
    @discardableResult
    public func width(_ w: CGFloat) -> ItemsChain<Item> {
        return each { $0.constrain.width(w) }
    }

    @discardableResult
    public func height(_ h: CGFloat) -> ItemsChain<Item> {
        return each { $0.constrain.height(h) }
    }

    @discardableResult
    public func size() -> ItemsChain<Item> {
        return merge([width(), height()])
    }

    @discardableResult
    public func size(_ s: CGFloat) -> ItemsChain<Item> {
        return size(width: s, height: s)
    }

    @discardableResult
    public func size(_ cgSize: CGSize) -> ItemsChain<Item> {
        return size(width: cgSize.width, height: cgSize.height)
    }

    @discardableResult
    public func size(width w: CGFloat, height h: CGFloat) -> ItemsChain<Item> {
        return each { $0.constrain.size(width: w, height: h) }
    }
}
