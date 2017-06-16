//
//  ItemsFunctions.swift
//  Bamboo
//
//  Created by Javier on 10/28/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import Foundation

extension ItemsConstraintChain {
    @discardableResult
    public func each<Chain: ConstraintChain>(constrain: (Item) -> Chain) -> ItemsChain<Item> {
        return add(items.map { constrain($0) })
    }

    @discardableResult
    public func between<Chain: ConstraintChain>(
        constrain: (_ first: Item, _ second: Item) -> Chain
    ) -> ItemsChain<Item> {
        let chains = zip(items, items.dropFirst()).map { constrain($0, $1) }
        return add(chains)
    }
}
