//
//  HTTPClient.swift
//  Sailor
//
//  Created by Prudhvi Gadiraju on 8/8/20.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
