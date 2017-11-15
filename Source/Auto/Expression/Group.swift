//
//  Group.swift
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

import Foundation

var shouldActivate = true

class ConstraintStack {
    static let shared = ConstraintStack()

    private var constraints = [[NSLayoutConstraint]]()

    func push() {
        constraints.append([NSLayoutConstraint]())
    }

    func pop() -> [NSLayoutConstraint] {
        return constraints.removeLast()
    }

    func append(_ constraint: NSLayoutConstraint) {
        for index in constraints.indices {
            constraints[index].append(constraint)
        }
    }
}

/// Group constraints created in the closure.
/// When nested, the outer function will return constraints including the ones created in inner functions.
///
/// - parameters:
///   - activated: Should activate constraints, defaults to `true`.
///   - constraints: Create constraints.
/// - returns: Constraints created in the closure.
@discardableResult
public func group(activated: Bool = true, constraints: () -> ()) -> [NSLayoutConstraint] {
    let oldActivate = shouldActivate
    shouldActivate = activated
    ConstraintStack.shared.push()
    constraints()
    shouldActivate = oldActivate
    return ConstraintStack.shared.pop()
}
