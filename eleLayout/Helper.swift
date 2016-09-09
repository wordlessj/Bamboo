//
//  Helper.swift
//  eleLayout
//
//  Created by Javier on 8/22/16.
//  Copyright © 2016 Javier. All rights reserved.
//

#if os(iOS)
    import UIKit
#else
    import AppKit
#endif

extension NSLayoutAttribute {
    var removingMargin: NSLayoutAttribute {
        #if os(iOS)
            switch self {
            case .leftMargin:           return .left
            case .rightMargin:          return .right
            case .topMargin:            return .top
            case .bottomMargin:         return .bottom
            case .leadingMargin:        return .leading
            case .trailingMargin:       return .trailing
            case .centerXWithinMargins: return .centerX
            case .centerYWithinMargins: return .centerY
            default:                    return self
            }
        #else
            return self
        #endif
    }

    var flipped: NSLayoutAttribute {
        switch self {
        case .left:     return .right
        case .right:    return .left
        case .top:      return .bottom
        case .bottom:   return .top
        case .leading:  return .trailing
        case .trailing: return .leading
        default:        return self
        }
    }
}

extension NSLayoutRelation {
    var reversed: NSLayoutRelation {
        switch self {
        case .lessThanOrEqual: return .greaterThanOrEqual
        case .equal: return .equal
        case .greaterThanOrEqual: return .lessThanOrEqual
        }
    }
}
