//
//  EdgeProtocol.swift
//  eleLayout
//
//  Created by Javier on 8/22/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import Foundation

public protocol EdgeProtocol {
    var left: CGFloat { get set }
    var right: CGFloat { get set }
    var top: CGFloat { get set }
    var bottom: CGFloat { get set }
}

extension EdgeProtocol {
    public func edge(edge: LayoutEdge) -> CGFloat {
        switch edge {
        case .left: return left
        case .right: return right
        case .top: return top
        case .bottom: return bottom
        }
    }

    public mutating func setEdge(edge: LayoutEdge, value: CGFloat) -> Self {
        switch edge {
        case .left: left = value
        case .right: right = value
        case .top: top = value
        case .bottom: bottom = value
        }

        return self
    }
}

extension EdgeInsets: EdgeProtocol {}
