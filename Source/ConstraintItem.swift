//
//  ConstraintItem.swift
//  Bamboo
//
//  Created by Javier on 10/28/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import Foundation

public protocol ConstraintItem: XAxisItem, YAxisItem, DimensionItem {
    var superview: View? { get }

    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
    var firstBaselineAnchor: NSLayoutYAxisAnchor { get }
    var lastBaselineAnchor: NSLayoutYAxisAnchor { get }
}

extension ConstraintItem {
    public var constrain: InitialChain<Self> {
        return InitialChain(item: self)
    }
}

extension View: ConstraintItem {}

#if os(iOS)
    extension UILayoutGuide: ConstraintItem {
        public var superview: View? { return owningView }

        public var firstBaselineAnchor: NSLayoutYAxisAnchor { return topAnchor }
        public var lastBaselineAnchor: NSLayoutYAxisAnchor { return bottomAnchor }
    }
#endif
