//
//  ItemsSizeFunctions.swift
//  eleLayout
//
//  Created by Javier on 10/28/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import Foundation

extension ConstraintItemsChain {
    @discardableResult
    public func width(_ w: CGFloat) -> ConstraintItemsMany<Item> {
        return each { $0.constrain.width(w) }
    }

    @discardableResult
    public func height(_ h: CGFloat) -> ConstraintItemsMany<Item> {
        return each { $0.constrain.height(h) }
    }

    @discardableResult
    public func size() -> ConstraintItemsMany<Item> {
        return constraintItemsMany(width().constraints + height().constraints)
    }

    @discardableResult
    public func size(_ s: CGFloat) -> ConstraintItemsMany<Item> {
        return size(width: s, height: s)
    }

    @discardableResult
    public func size(_ cgSize: CGSize) -> ConstraintItemsMany<Item> {
        return size(width: cgSize.width, height: cgSize.height)
    }

    @discardableResult
    public func size(width w: CGFloat, height h: CGFloat) -> ConstraintItemsMany<Item> {
        return each { $0.constrain.size(width: w, height: h).constraints }
    }
}
