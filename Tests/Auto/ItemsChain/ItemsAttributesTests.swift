//
//  ItemsAttributesTests.swift
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

class ItemsAttributesTests: BaseTestCase {
    func testLeft() {
        let constraints = subviews.constrain.left().constraints
        let testConstraints = betweenConstraints(.left)
        XCTAssertEqual(constraints, testConstraints)
    }

    func testRight() {
        let constraints = subviews.constrain.right().constraints
        let testConstraints = betweenConstraints(.right)
        XCTAssertEqual(constraints, testConstraints)
    }

    func testTop() {
        let constraints = subviews.constrain.top().constraints
        let testConstraints = betweenConstraints(.top)
        XCTAssertEqual(constraints, testConstraints)
    }

    func testBottom() {
        let constraints = subviews.constrain.bottom().constraints
        let testConstraints = betweenConstraints(.bottom)
        XCTAssertEqual(constraints, testConstraints)
    }

    func testLeading() {
        let constraints = subviews.constrain.leading().constraints
        let testConstraints = betweenConstraints(.leading)
        XCTAssertEqual(constraints, testConstraints)
    }

    func testTrailing() {
        let constraints = subviews.constrain.trailing().constraints
        let testConstraints = betweenConstraints(.trailing)
        XCTAssertEqual(constraints, testConstraints)
    }

    func testWidth() {
        let constraints = subviews.constrain.width().constraints
        let testConstraints = betweenConstraints(.width)
        XCTAssertEqual(constraints, testConstraints)
    }

    func testHeight() {
        let constraints = subviews.constrain.height().constraints
        let testConstraints = betweenConstraints(.height)
        XCTAssertEqual(constraints, testConstraints)
    }

    func testCenterX() {
        let constraints = subviews.constrain.centerX().constraints
        let testConstraints = betweenConstraints(.centerX)
        XCTAssertEqual(constraints, testConstraints)
    }

    func testCenterY() {
        let constraints = subviews.constrain.centerY().constraints
        let testConstraints = betweenConstraints(.centerY)
        XCTAssertEqual(constraints, testConstraints)
    }

    func testFirstBaseline() {
        let constraints = subviews.constrain.firstBaseline().constraints
        let testConstraints = betweenConstraints(.firstBaseline)
        XCTAssertEqual(constraints, testConstraints)
    }

    func testLastBaseline() {
        let constraints = subviews.constrain.lastBaseline().constraints
        let testConstraints = betweenConstraints(.lastBaseline)
        XCTAssertEqual(constraints, testConstraints)
    }

    func testChains() {
        let constraints = subviews.constrain.left().right().constraints
        let testConstraints = betweenConstraints(.left) + betweenConstraints(.right)
        XCTAssertEqual(constraints, testConstraints)
    }
}
