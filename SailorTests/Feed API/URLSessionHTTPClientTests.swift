//
//  URLSessionHTTPClientTests.swift
//  SailorTests
//
//  Created by Prudhvi Gadiraju on 8/9/20.
//

import XCTest

class URLSessionHTTPClient {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func get(from url: URL) {
        session.dataTask(with: url) { _,_,_ in
            
        }
    }
}

class URLSessionHTTPClientTests: XCTestCase {
    func test_getFromURL_createsDataTaskFromURL() {
        let url = URL(string: "https://any-url.com")!
        let session = URLSessionSpy()
        let sut = URLSessionHTTPClient(session: session)
        
        sut.get(from: url)
        
        XCTAssertEqual(session.requestedURLs, [url])
    }
    
    private class URLSessionSpy: URLSession {
        var requestedURLs: [URL] = []
        
        override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            requestedURLs.append(url)
            return FakeURLSessionDataTask()
        }
    }
    
    private class FakeURLSessionDataTask: URLSessionDataTask {}
}
