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
            case .LeftMargin:           return .Left
            case .RightMargin:          return .Right
            case .TopMargin:            return .Top
            case .BottomMargin:         return .Bottom
            case .LeadingMargin:        return .Leading
            case .TrailingMargin:       return .Trailing
            case .CenterXWithinMargins: return .CenterX
            case .CenterYWithinMargins: return .CenterY
            default:                    return self
            }
        #else
            return self
        #endif
    }

    var flipped: NSLayoutAttribute {
        switch self {
        case .Left:     return .Right
        case .Right:    return .Left
        case .Top:      return .Bottom
        case .Bottom:   return .Top
        case .Leading:  return .Trailing
        case .Trailing: return .Leading
        default:        return self
        }
    }
}

extension NSLayoutRelation {
    var reversed: NSLayoutRelation {
        switch self {
        case .LessThanOrEqual: return .GreaterThanOrEqual
        case .Equal: return .Equal
        case .GreaterThanOrEqual: return .LessThanOrEqual
        }
    }
}
