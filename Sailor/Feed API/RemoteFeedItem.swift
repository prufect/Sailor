//
//  RemoteFeedItem.swift
//  Sailor
//
//  Created by Prudhvi Gadiraju on 8/10/20.
//

import Foundation

struct RemoteFeedItem: Equatable, Decodable {
    let id: UUID
    let description: String?
    let location: String?
    let image: URL
}
