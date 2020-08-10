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
    
    func test_validateCache_doesNotDeleteCacheOnEmptyCache() {
        let (sut, store) = makeSUT()
        
        sut.validateCache()
        store.completeRetrievalWithEmptyCache()
        
        XCTAssertEqual(store.receivedMessages, [.retrieve])
    }
    
    func test_validateCache_doesNotDeleteCacheLessThanSevenDaysOldCache() {
         let feed = uniqueImageFeed()
         let fixedCurrentDate = Date()
         let lessThanSevenDaysOldTimeStamp = fixedCurrentDate.adding(days: -7).adding(seconds: 1)
         let (sut, store) = makeSUT(timestamp: { fixedCurrentDate })
         
         sut.validateCache()
         store.completeRetrieval(with: feed.local, timestamp: lessThanSevenDaysOldTimeStamp)
         
         XCTAssertEqual(store.receivedMessages, [.retrieve])
     }
    
    func test_validateCache_deletesCacheOnSevenDaysOldCache() {
        let feed = uniqueImageFeed()
        let fixedCurrentDate = Date()
        let sevenDaysOldTimeStamp = fixedCurrentDate.adding(days: -7)
        let (sut, store) = makeSUT(timestamp: { fixedCurrentDate })
        
        sut.validateCache()
        store.completeRetrieval(with: feed.local, timestamp: sevenDaysOldTimeStamp)
        
        XCTAssertEqual(store.receivedMessages, [.retrieve, .deleteCachedFeed])
    }
    
    func test_validateCache_deletesCacheOnMoreThanSevenDaysOldCache() {
        let feed = uniqueImageFeed()
        let fixedCurrentDate = Date()
        let moreThanSevenDaysOldTimeStamp = fixedCurrentDate.adding(days: -7).advanced(by: -1)
        let (sut, store) = makeSUT(timestamp: { fixedCurrentDate })
        
        sut.validateCache()
        store.completeRetrieval(with: feed.local, timestamp: moreThanSevenDaysOldTimeStamp)
        
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
}
