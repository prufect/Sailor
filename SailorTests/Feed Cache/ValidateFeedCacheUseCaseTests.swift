//
//  ValidateFeedCacheUseCaseTests.swift
//  SailorTests
//
//  Created by Prudhvi Gadiraju on 8/10/20.
//

import XCTest
import Sailor

class ValidateFeedCacheUseCaseTests: XCTestCase {

    func test_init_doesNotSendMessageUponCreation() {
        let (_, store) = makeSUT()
        
        XCTAssertEqual(store.receivedMessages, [])
    }
    
    func test_validateCache_deletesCacheOnRetrievalError() {
         let (sut, store) = makeSUT()
         
         sut.validateCache()
         store.completeRetrieval(with: anyError())
         
        XCTAssertEqual(store.receivedMessages, [.retrieve, .deleteCachedFeed])
     }
    
    // MARK: - Helpers

    private func makeSUT(timestamp: @escaping () -> Date = { Date() }, file: StaticString = #file, line: UInt = #line) -> (sut: LocalFeedLoader, store: FeedStoreSpy) {
        let store = FeedStoreSpy()
        let sut = LocalFeedLoader(store: store, currentDate: timestamp)
        
        trackForMemoryLeaks(store, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, store)
    }
    
    private func anyError() -> NSError {
        NSError(domain: "AnyError", code: 0)
    }
}
