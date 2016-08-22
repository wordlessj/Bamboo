//
//  LayoutAttributes.swift
//  eleLayout
//
//  Created by Javier on 8/22/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import Foundation

public enum LayoutEdge {
    case left, right, top, bottom

    public init?(_ axis: LayoutAxis) {
        switch axis {
        case .left: self = .left
        case .right: self = .right
        case .top: self = .top
        case .bottom: self = .bottom
        default: return nil
        }
    }
}

public enum LayoutAxis {
    case left, right, top, bottom, centerX, centerY

    public init(_ edge: LayoutEdge) {
        switch edge {
        case .left: self = .left
        case .right: self = .right
        case .top: self = .top
        case .bottom: self = .bottom
        }
    }
}

public enum LayoutDimension { case width, height }
