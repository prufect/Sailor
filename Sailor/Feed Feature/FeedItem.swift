//
//  FeedItem.swift
//  Sailor
//
//  Created by Prudhvi Gadiraju on 8/7/20.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
