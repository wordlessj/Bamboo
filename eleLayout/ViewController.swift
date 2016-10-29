//
//  ViewController.swift
//  eleLayout
//
//  Created by Javier on 10/28/16.
//  Copyright © 2016 Javier. All rights reserved.
//

import UIKit

public struct ViewControllerConstrain {
    var viewController: UIViewController
}

extension ViewControllerConstrain {
    public var topLayoutGuide: ConstraintExpression {
        return ConstraintParameter(item: viewController.topLayoutGuide, attribute: .bottom)
    }

    public var bottomLayoutGuide: ConstraintExpression {
        return ConstraintParameter(item: viewController.bottomLayoutGuide, attribute: .top)
    }
}

extension UIViewController {
    public var constrain: ViewControllerConstrain { return ViewControllerConstrain(viewController: self) }
}
