//
//  FeedViewControllerTests.swift
//  SailoriOSTests
//
//  Created by Prudhvi Gadiraju on 8/13/20.
//

import XCTest
import UIKit
import Sailor

final class FeedViewController: UIViewController {
    private var loader: FeedLoader?
    
    convenience init(loader: FeedLoader) {
        self.init()
        self.loader = loader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loader?.load { _ in }
    }
}

class FeedViewControllerTests: XCTestCase {
    
    func test_init_doesNotLoadFeed() {
        let (_, loader) = makeSUT()
        
        XCTAssertEqual(loader.loadCount, 0)
    }
    
    func test_viewDidLoad_loadsFeed() {
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(loader.loadCount, 1)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        file: StaticString = #file,
        line: UInt = #line)
        -> (sut: FeedViewController, loader: LoaderSpy)
    {
        let loader = LoaderSpy()
        let sut = FeedViewController(loader: loader)
        trackForMemoryLeaks(loader)
        trackForMemoryLeaks(sut)
        return (sut, loader)
    }
    
    private class LoaderSpy: FeedLoader {
        private(set) var loadCount = 0
        
        func load(completion: @escaping (LoadFeedResult) -> Void) {
            loadCount += 1
        }
    }
}
