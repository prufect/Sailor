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
    
    private func uniqueImage() -> FeedImage {
        FeedImage(id: UUID(), description: "any", location: "any", url: anyURL())
    }
    
    private func uniqueImageFeed() -> (models: [FeedImage], local: [LocalFeedImage]) {
        let feed = [uniqueImage(), uniqueImage()]
        let localFeed = feed.map { LocalFeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.url)}
        return (feed, localFeed)
    }
    
    private func anyURL() -> URL {
        URL(string: "https://any-url.com")!
    }
}

private extension Date {
    func adding(days: Int) -> Date {
        return Calendar(identifier: .gregorian).date(byAdding: .day, value: days, to: self)!
    }
    
    func adding(seconds: TimeInterval) -> Date {
        return self + seconds
    }
}
