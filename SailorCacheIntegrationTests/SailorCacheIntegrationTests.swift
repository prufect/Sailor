//
//  SailorCacheIntegrationTests.swift
//  SailorCacheIntegrationTests
//
//  Created by Prudhvi Gadiraju on 8/12/20.
//

import XCTest
import Sailor

class SailorCacheIntegrationTests: XCTestCase {
    
    func test_load_deliversNoItemsOnEmptyCache() {
        let sut = makeSUT()
        
        let exp = expectation(description: "Wait for Load Completion")
        sut.load { result in
            switch result {
            case let .success(imageFeed):
                XCTAssertEqual(imageFeed, [], "Expected Empty Feed")
            case let .failure(error):
                XCTFail("Expected success, but got \(error) instead")
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func makeSUT() -> LocalFeedLoader {
        let store = CodableFeedStore(storeURL: testStoreURL())
        let sut = LocalFeedLoader(store: store, currentDate: Date.init)
        trackForMemoryLeaks(sut)
        trackForMemoryLeaks(store)
        return sut
    }
    
    func testStoreURL() -> URL {
        FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent("\(type(of: self)).store")
    }
}
