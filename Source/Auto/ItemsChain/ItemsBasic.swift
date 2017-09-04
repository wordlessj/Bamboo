//
//  ItemsBasic.swift
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

extension ItemsConstraintChain {
    /// Create constraints for each item. For example:
    ///
    /// ```
    /// [a, b, c].bb.each {
    ///     $0.bb.width(10)
    /// }
    /// ```
    @discardableResult
    public func each<Chain: ConstraintChain>(constrain: (Item) -> Chain) -> ItemsChain<Item> {
        return add(items.map { constrain($0) })
    }

    /// Create constraints between every two items. For example:
    ///
    /// ```
    /// [a, b, c].bb.between {
    ///     $0.bb.left($1)
    /// }
    /// ```
    ///
    /// It creates constraints between `a` and `b`, `b` and `c`.
    @discardableResult
    public func between<Chain: ConstraintChain>(
        constrain: (_ first: Item, _ second: Item) -> Chain
    ) -> ItemsChain<Item> {
        let chains = zip(items, items.dropFirst()).map { constrain($0, $1) }
        return add(chains)
    }

    /// Create constraints between every three items.
    @discardableResult
    public func triple<Chain: ConstraintChain>(
        constrain: (_ first: Item, _ second: Item, _ third: Item) -> Chain
    ) -> ItemsChain<Item> {
        let chains = (min(2, items.count)..<items.count).map { index in
            constrain(items[index - 2], items[index - 1], items[index])
        }
        return add(chains)
    }
}
