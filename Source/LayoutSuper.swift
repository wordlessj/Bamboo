//
//  LayoutSuper.swift
//  Bamboo
//
//  Created by Javier on 12/6/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import Foundation

extension LayoutChain {
    public var superSize: CGSize { return item.superItem?.size ?? .zero }
    public var superCenter: CGPoint { return CGPoint(x: superSize.width / 2, y: superSize.height / 2) }
    public var superLeft: CGFloat { return 0 }
    public var superRight: CGFloat { return superSize.width }
    public var superTop: CGFloat { return 0 }
    public var superBottom: CGFloat { return superSize.height }
}
