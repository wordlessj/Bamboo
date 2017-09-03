//
//  ItemsDistribute.swift
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

/// Inset mode used with distribute.
public enum DistributeInset {
    /// No insets.
    case none

    /// Fixed inset.
    case fixed(CGFloat)

    /// Insets are equal.
    @available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
    case equal
}

private enum DistributeAxis {
    case x, y
}

extension ItemsConstraintChain {
    /// Distribute items along x-axis with fixed spacing.
    ///
    /// - parameters:
    ///   - spacing: Fixed spacing between items, defaults to 0.
    ///   - inset: Inset mode, defaults to `none`.
    ///     - `none`: `a-b-c`, no insets.
    ///     - `fixed`: `|-(inset)-a-b-c-(inset)-|`, `inset`s are fixed.
    ///     - `equal`: `|-(inset)-a-b-c-(inset)-|`, `inset`s are equal.
    @discardableResult
    public func distributeX(spacing: CGFloat = 0, inset: DistributeInset = .none) -> ItemsChain<Item> {
        return distribute(axis: .x, spacing: spacing, inset: inset)
    }

    /// Distribute items along y-axis with fixed spacing.
    ///
    /// - parameters:
    ///   - spacing: Fixed spacing between items, defaults to 0.
    ///   - inset: Inset mode, defaults to `none`.
    ///     - `none`: `V:a-b-c`, no insets.
    ///     - `fixed`: `V:|-(inset)-a-b-c-(inset)-|`, `inset`s are fixed.
    ///     - `equal`: `V:|-(inset)-a-b-c-(inset)-|`, `inset`s are equal.
    @discardableResult
    public func distributeY(spacing: CGFloat = 0, inset: DistributeInset = .none) -> ItemsChain<Item> {
        return distribute(axis: .y, spacing: spacing, inset: inset)
    }

    /// Distribute items along x-axis with equal spacing.
    ///
    /// - parameter inset: Inset mode, defaults to `none`.
    ///   - `none`: `a-b-c`, no insets.
    ///   - `fixed`: `|-(inset)-a-b-c-(inset)-|`, `inset`s are fixed.
    ///   - `equal`: `|-(inset)-a-b-c-(inset)-|`, `inset`s are equal to spacing between items.
    @available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
    @discardableResult
    public func distributeXEqualSpacing(inset: DistributeInset = .none) -> ItemsChain<Item> {
        return distributeEqualSpacing(axis: .x, inset: inset)
    }

    /// Distribute items along y-axis with equal spacing.
    ///
    /// - parameter inset: Inset mode, defaults to `none`.
    ///   - `none`: `V:a-b-c`, no insets.
    ///   - `fixed`: `V:|-(inset)-a-b-c-(inset)-|`, `inset`s are fixed.
    ///   - `equal`: `V:|-(inset)-a-b-c-(inset)-|`, `inset`s are equal to spacing between items.
    @available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
    @discardableResult
    public func distributeYEqualSpacing(inset: DistributeInset = .none) -> ItemsChain<Item> {
        return distributeEqualSpacing(axis: .y, inset: inset)
    }

    private func distribute(axis: DistributeAxis, spacing: CGFloat, inset: DistributeInset) -> ItemsChain<Item> {
        var chain = between { first, second -> SingleChain<Item> in
            switch axis {
            case .x: return second.constrain.after(first, spacing: spacing)
            case .y: return second.constrain.below(first, spacing: spacing)
            }
        }

        switch inset {
        case let .fixed(s):
            chain = chain.inset(s, axis: axis)
        case .equal:
            if #available(iOS 10.0, macOS 10.12, tvOS 10.0, *) {
                chain = chain.insetEqualSpacing(axis: axis)
            }
        case .none: break
        }

        return chain
    }

    @available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
    private func distributeEqualSpacing(axis: DistributeAxis, inset: DistributeInset) -> ItemsChain<Item> {
        var chain = triple { first, second, third -> SingleChain<Item> in
            switch axis {
            case .x: return first.constrain.offset(second.leadingAnchor - first.trailingAnchor,
                                                   third.leadingAnchor - second.trailingAnchor)
            case .y: return first.constrain.offset(second.topAnchor - first.bottomAnchor,
                                                   third.topAnchor - second.bottomAnchor)
            }
        }

        switch inset {
        case let .fixed(s):
            chain = chain.inset(s, axis: axis)
        case .equal:
            chain = chain.insetEqualSpacing(axis: axis)

            if items.count >= 2 {
                let first = items[0]
                let second = items[1]
                let newChain: SingleChain<Item>

                switch axis {
                case .x: newChain = first.constrain.offset(first.leadingAnchor - first.superview!.leadingAnchor,
                                                           second.leadingAnchor - first.trailingAnchor)
                case .y: newChain = first.constrain.offset(first.topAnchor - first.superview!.topAnchor,
                                                           second.topAnchor - first.bottomAnchor)
                }

                chain = chain.add([newChain])
            }
        case .none: break
        }

        return chain
    }

    private func inset(_ spacing: CGFloat, axis: DistributeAxis) -> ItemsChain<Item> {
        var chains = [SingleChain<Item>]()

        if let first = items.first {
            switch axis {
            case .x: chains.append(first.constrain.leading(spacing))
            case .y: chains.append(first.constrain.top(spacing))
            }
        }

        if let last = items.last {
            switch axis {
            case .x: chains.append(last.constrain.trailing(-spacing))
            case .y: chains.append(last.constrain.bottom(-spacing))
            }
        }

        return add(chains)
    }

    @available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
    private func insetEqualSpacing(axis: DistributeAxis) -> ItemsChain<Item> {
        var chains = [SingleChain<Item>]()

        if let first = items.first, let last = items.last {
            let chain: SingleChain<Item>

            switch axis {
            case .x: chain = first.constrain.offset(first.leadingAnchor - first.superview!.leadingAnchor,
                                                    last.superview!.trailingAnchor - last.trailingAnchor)
            case .y: chain = first.constrain.offset(first.topAnchor - first.superview!.topAnchor,
                                                    last.superview!.bottomAnchor - last.bottomAnchor)
            }

            chains.append(chain)
        }

        return add(chains)
    }
}

extension ItemsConstraintChain {
    @available(*, deprecated, renamed: "distributeX()")
    @discardableResult
    public func distributeHorizontally(spacing: CGFloat = 0) -> ItemsChain<Item> {
        return distributeX(spacing: spacing)
    }

    @available(*, deprecated, renamed: "distributeY()")
    @discardableResult
    public func distributeVertically(spacing: CGFloat = 0) -> ItemsChain<Item> {
        return distributeY(spacing: spacing)
    }
}
