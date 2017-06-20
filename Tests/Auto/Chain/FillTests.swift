//
//  FillTests.swift
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

import XCTest
import Bamboo

private let insets = EdgeInsets(top: 3, left: 1, bottom: 4, right: 2)

class FillTests: BaseTestCase {
    private var leftConstraint: NSLayoutConstraint {
        return NSLayoutConstraint(item: view1, attribute: .left, toItem: superview, constant: insets.left)
    }

    private var rightConstraint: NSLayoutConstraint {
        return NSLayoutConstraint(item: view1, attribute: .right, toItem: superview, constant: -insets.right)
    }

    private var topConstraint: NSLayoutConstraint {
        return NSLayoutConstraint(item: view1, attribute: .top, toItem: superview, constant: insets.top)
    }

    private var bottomConstraint: NSLayoutConstraint {
        return NSLayoutConstraint(item: view1, attribute: .bottom, toItem: superview, constant: -insets.bottom)
    }

    private var leadingConstraint: NSLayoutConstraint {
        return NSLayoutConstraint(item: view1, attribute: .leading, toItem: superview, constant: insets.left)
    }

    private var trailingConstraint: NSLayoutConstraint {
        return NSLayoutConstraint(item: view1, attribute: .trailing, toItem: superview, constant: -insets.right)
    }

    func testFill() {
        let constraints = view1.constrain.fill(insets: insets).constraints
        let testConstraints = [topConstraint, bottomConstraint, leadingConstraint, trailingConstraint]
        XCTAssertEqual(constraints, testConstraints)
    }

    func testFillLeft() {
        let constraints = view1.constrain.fillLeft(insets: insets).constraints
        let testConstraints = [leftConstraint, topConstraint, bottomConstraint]
        XCTAssertEqual(constraints, testConstraints)
    }

    func testFillRight() {
        let constraints = view1.constrain.fillRight(insets: insets).constraints
        let testConstraints = [rightConstraint, topConstraint, bottomConstraint]
        XCTAssertEqual(constraints, testConstraints)
    }

    func testFillTop() {
        let constraints = view1.constrain.fillTop(insets: insets).constraints
        let testConstraints = [topConstraint, leadingConstraint, trailingConstraint]
        XCTAssertEqual(constraints, testConstraints)
    }

    func testFillBottom() {
        let constraints = view1.constrain.fillBottom(insets: insets).constraints
        let testConstraints = [bottomConstraint, leadingConstraint, trailingConstraint]
        XCTAssertEqual(constraints, testConstraints)
    }

    func testFillLeading() {
        let constraints = view1.constrain.fillLeading(insets: insets).constraints
        let testConstraints = [topConstraint, bottomConstraint, leadingConstraint]
        XCTAssertEqual(constraints, testConstraints)
    }

    func testFillTrailing() {
        let constraints = view1.constrain.fillTrailing(insets: insets).constraints
        let testConstraints = [topConstraint, bottomConstraint, trailingConstraint]
        XCTAssertEqual(constraints, testConstraints)
    }

    func testFillWidth() {
        let constraints = view1.constrain.fillWidth(insets: insets).constraints
        let testConstraints = [leadingConstraint, trailingConstraint]
        XCTAssertEqual(constraints, testConstraints)
    }

    func testFillHeight() {
        let constraints = view1.constrain.fillHeight(insets: insets).constraints
        let testConstraints = [topConstraint, bottomConstraint]
        XCTAssertEqual(constraints, testConstraints)
    }
}
