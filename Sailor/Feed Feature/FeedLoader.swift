//
//  FeedLoader.swift
//  Sailor
//
//  Created by Prudhvi Gadiraju on 8/7/20.
//

import Foundation

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
