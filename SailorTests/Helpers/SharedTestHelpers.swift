//
//  SharedTestHelpers.swift
//  SailorTests
//
//  Created by Prudhvi Gadiraju on 8/10/20.
//

import Foundation

func anyError() -> NSError {
    NSError(domain: "AnyError", code: 0)
}

func anyURL() -> URL {
    URL(string: "https://any-url.com")!
}
