//
//  XCTestCase+MemoryLeakTracker.swift
//  SailorTests
//
//  Created by Prudhvi Gadiraju on 8/9/20.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Potential Memory Leak", file: file, line: line)
        }
    }
}
