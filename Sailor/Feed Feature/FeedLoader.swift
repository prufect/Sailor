//
//  FeedLoader.swift
//  Sailor
//
//  Created by Prudhvi Gadiraju on 8/7/20.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedImage])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
