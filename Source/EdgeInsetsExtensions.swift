//
//  EdgeInsetsExtensions.swift
//  Bamboo
//
//  Created by Javier on 10/28/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import Foundation

extension EdgeInsets: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        let floatValue = CGFloat(value)
        self.init(top: floatValue, left: floatValue, bottom: floatValue, right: floatValue)
    }
}

extension EdgeInsets: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        let floatValue = CGFloat(value)
        self.init(top: floatValue, left: floatValue, bottom: floatValue, right: floatValue)
    }
}
