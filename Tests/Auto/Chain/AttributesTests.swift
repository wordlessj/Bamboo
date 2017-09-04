//
//  AttributesTests.swift
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

class AttributesTests: BaseTestCase {
    func testLeft() {
        let constraint = view1.bb.left().constraint
        let testConstraint = NSLayoutConstraint(item: view1, attribute: .left, toItem: superview)
        XCTAssertEqual(constraint, testConstraint)
    }

    func testRight() {
        let constraint = view1.bb.right().constraint
        let testConstraint = NSLayoutConstraint(item: view1, attribute: .right, toItem: superview)
        XCTAssertEqual(constraint, testConstraint)
    }

    func testTop() {
        let constraint = view1.bb.top().constraint
        let testConstraint = NSLayoutConstraint(item: view1, attribute: .top, toItem: superview)
        XCTAssertEqual(constraint, testConstraint)
    }

    func testBottom() {
        let constraint = view1.bb.bottom().constraint
        let testConstraint = NSLayoutConstraint(item: view1, attribute: .bottom, toItem: superview)
        XCTAssertEqual(constraint, testConstraint)
    }

    func testLeading() {
        let constraint = view1.bb.leading().constraint
        let testConstraint = NSLayoutConstraint(item: view1, attribute: .leading, toItem: superview)
        XCTAssertEqual(constraint, testConstraint)
    }

    func testTrailing() {
        let constraint = view1.bb.trailing().constraint
        let testConstraint = NSLayoutConstraint(item: view1, attribute: .trailing, toItem: superview)
        XCTAssertEqual(constraint, testConstraint)
    }

    func testWidth() {
        let constraint = view1.bb.width().constraint
        let testConstraint = NSLayoutConstraint(item: view1, attribute: .width, toItem: superview)
        XCTAssertEqual(constraint, testConstraint)
    }

    func testHeight() {
        let constraint = view1.bb.height().constraint
        let testConstraint = NSLayoutConstraint(item: view1, attribute: .height, toItem: superview)
        XCTAssertEqual(constraint, testConstraint)
    }

    func testCenterX() {
        let constraint = view1.bb.centerX().constraint
        let testConstraint = NSLayoutConstraint(item: view1, attribute: .centerX, toItem: superview)
        XCTAssertEqual(constraint, testConstraint)
    }

    func testCenterY() {
        let constraint = view1.bb.centerY().constraint
        let testConstraint = NSLayoutConstraint(item: view1, attribute: .centerY, toItem: superview)
        XCTAssertEqual(constraint, testConstraint)
    }

    func testFirstBaseline() {
        let constraint = view1.bb.firstBaseline().constraint
        let testConstraint = NSLayoutConstraint(item: view1, attribute: .firstBaseline, toItem: superview)
        XCTAssertEqual(constraint, testConstraint)
    }

    func testLastBaseline() {
        let constraint = view1.bb.lastBaseline().constraint
        let testConstraint = NSLayoutConstraint(item: view1, attribute: .lastBaseline, toItem: superview)
        XCTAssertEqual(constraint, testConstraint)
    }

    func testOffset() {
        let constraint = view1.bb.offset(view1.widthAnchor, view2.widthAnchor).constraint
        let testConstraint = NSLayoutConstraint(item: view1, attribute: .width, toItem: view2)
        XCTAssertEqual(constraint, testConstraint)
    }

    func testAspectRatio() {
        let constraint = view1.bb.aspectRatio(value).constraint
        let testConstraint = NSLayoutConstraint(item: view1, attribute: .width,
                                                toItem: view1, toAttribute: .height,
                                                multiplier: value)
        XCTAssertEqual(constraint, testConstraint)
    }

    func testDifferentAxis() {
        let constraint = view1.bb.left(view2.rightAnchor).constraint
        let testConstraint = NSLayoutConstraint(item: view1, attribute: .left, toItem: view2, toAttribute: .right)
        XCTAssertEqual(constraint, testConstraint)
    }

    func testAxisWithFullExpression() {
        let priority = LayoutPriority.defaultHigh
        let constraint = view1.bb.left(>=view2 + value ~ priority).constraint
        let testConstraint = NSLayoutConstraint(item: view1, attribute: .left,
                                                toItem: view2, toAttribute: .left,
                                                constant: value, relation: .greaterThanOrEqual, priority: priority)
        XCTAssertEqual(constraint, testConstraint)
        XCTAssertTrue(constraint.isActive)
    }

    #if os(iOS) || os(tvOS)
    @available(iOS 11.0, tvOS 11.0, *)
    func testAxisWithSystemSpacing() {
        let multiplier: CGFloat = 2
        let constraint = view1.bb.left(view2 + SystemSpacing(multiplier)).constraint
        let testConstraint = NSLayoutConstraint(item: view1, attribute: .left, toItem: view2, constant: 16)
        XCTAssertEqual(constraint, testConstraint)
    }
    #endif

    func testDimensionWithValue() {
        let constraint = view1.bb.width(value).constraint
        let testConstraint = NSLayoutConstraint(item: view1, dimension: .width, constant: value)
        XCTAssertEqual(constraint, testConstraint)
    }

    func testDimensionWithFullExpression() {
        let multiplier: CGFloat = 2
        let priority = LayoutPriority.defaultHigh
        let constraint = view1.bb.width(>=view2 * multiplier + value ~ priority).constraint
        let testConstraint = NSLayoutConstraint(item: view1, attribute: .width,
                                                toItem: view2, toAttribute: .width,
                                                multiplier: multiplier, constant: value,
                                                relation: .greaterThanOrEqual, priority: priority)
        XCTAssertEqual(constraint, testConstraint)
        XCTAssertTrue(constraint.isActive)
    }

    func testChains() {
        let constraints = view1.bb.left().right().constraints
        let testConstraints = [NSLayoutConstraint(item: view1, attribute: .left, toItem: superview),
                               NSLayoutConstraint(item: view1, attribute: .right, toItem: superview)]
        XCTAssertEqual(constraints, testConstraints)
    }
}
