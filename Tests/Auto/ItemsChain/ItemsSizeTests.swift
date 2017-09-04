//
//  ItemsSizeTests.swift
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

class ItemsSizeTests: BaseTestCase {
    func testWidth() {
        let constraints = subviews.bb.width(value).constraints
        let testConstraints = subviews.map { NSLayoutConstraint(item: $0, dimension: .width, constant: value) }
        XCTAssertEqual(constraints, testConstraints)
    }

    func testHeight() {
        let constraints = subviews.bb.height(value).constraints
        let testConstraints = subviews.map { NSLayoutConstraint(item: $0, dimension: .height, constant: value) }
        XCTAssertEqual(constraints, testConstraints)
    }

    func testSize() {
        let constraints = subviews.bb.size().constraints
        let testConstraints = betweenConstraints(.width) + betweenConstraints(.height)
        XCTAssertEqual(constraints, testConstraints)
    }

    func testSizeWithValues() {
        let width: CGFloat = 2
        let height: CGFloat = 3
        let constraints = subviews.bb.size(width: width, height: height).constraints
        let testConstraints = subviews.flatMap {
            [NSLayoutConstraint(item: $0, dimension: .width, constant: width),
             NSLayoutConstraint(item: $0, dimension: .height, constant: height)]
        }
        XCTAssertEqual(constraints, testConstraints)
    }
}
