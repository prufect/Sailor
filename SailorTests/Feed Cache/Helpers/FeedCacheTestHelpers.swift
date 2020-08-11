//
//  FeedCacheTestHelpers.swift
//  SailorTests
//
//  Created by Prudhvi Gadiraju on 8/10/20.
//

import Foundation
import Sailor

func uniqueImage() -> FeedImage {
    FeedImage(id: UUID(), description: "any", location: "any", url: anyURL())
}

func uniqueImageFeed() -> (models: [FeedImage], local: [LocalFeedImage]) {
    let feed = [uniqueImage(), uniqueImage()]
    let localFeed = feed.map { LocalFeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.url)}
    return (feed, localFeed)
}

extension Date {
    private var feedCacheMaxAgeInDays: Int { 7 }
    
    func minusFeedCacheMaxAge() -> Date {
        adding(days: -feedCacheMaxAgeInDays)
    }
    
    private func adding(days: Int) -> Date {
        return Calendar(identifier: .gregorian).date(byAdding: .day, value: days, to: self)!
    }
    
}

extension Date {
    func adding(seconds: TimeInterval) -> Date {
        return self + seconds
    }
}
