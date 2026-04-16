//
//  loadArticleMock.swift
//  News Reader AppTests
//
//  Created by Apple  on 16/04/2026.
//

import Foundation

let sampleArticles: [Article] = [
    Article(
        uri: "1",
        url: "https://test.com",
        id: 1,
        assetId: 1,
        source: "test",
        publishedDate: "2026-01-01",
        updated: nil,
        section: "world",
        subsection: nil,
        nytdsection: "world",
        type: "Article",
        title: "Test Title",
        abstract: "Test Abstract",
        byline: "Author",
        desFacet: nil,
        orgFacet: nil,
        perFacet: nil,
        geoFacet: nil,
        media: nil
    )
]

import XCTest

final class ArticleViewModelTests: XCTestCase {

    func test_loadArticles_success() {

        let repo = ArticleRepositoryMock()
        repo.result = .success(sampleArticles)

        let vm = ArticleViewModel(repository: repo)

        let expectation = XCTestExpectation(description: "load articles")

        vm.onStateChange = { state in
            if case .success = state {
                expectation.fulfill()
            }
        }

        vm.loadArticles()

        wait(for: [expectation], timeout: 1.0)

        XCTAssertEqual(vm.numberOfRows(), sampleArticles.count)
    }
    
    func test_loadArticles_empty() {

        let repo = ArticleRepositoryMock()
        repo.result = .success([])

        let vm = ArticleViewModel(repository: repo)

        let expectation = XCTestExpectation(description: "empty state")

        vm.onStateChange = { state in
            if case .empty = state {
                expectation.fulfill()
            }
        }

        vm.loadArticles()

        wait(for: [expectation], timeout: 1.0)

        XCTAssertEqual(vm.numberOfRows(), 0)
    }
    
    func test_loadArticles_failure() {

        let repo = ArticleRepositoryMock()
        repo.result = .failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "API Error"]))

        let vm = ArticleViewModel(repository: repo)

        let expectation = XCTestExpectation(description: "error state")

        vm.onStateChange = { state in
            if case .error = state {
                expectation.fulfill()
            }
        }

        vm.loadArticles()

        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_search_filters_articles() {

        let repo = ArticleRepositoryMock()
        repo.result = .success(sampleArticles)

        let vm = ArticleViewModel(repository: repo)

        vm.loadArticles()

        vm.search(query: "test")

        XCTAssertEqual(vm.numberOfRows(), vm.filteredArticles.count)
    }
    
    func test_search_empty_results() {

        let repo = ArticleRepositoryMock()
        repo.result = .success(sampleArticles)

        let vm = ArticleViewModel(repository: repo)

        vm.loadArticles()
        vm.search(query: "xyz_not_found")

        if case .empty = vm.state {
            XCTAssertTrue(true)
        } else {
            XCTFail("Expected empty state")
        }
    }
    func test_repository_fetch_is_called() {

        let repo = ArticleRepositoryMock()
        repo.result = .success([])

        let vm = ArticleViewModel(repository: repo)

        vm.loadArticles()

        XCTAssertTrue(repo.fetchCalled)
    }
    
    func test_search_reset_returns_all_articles() {

        let repo = ArticleRepositoryMock()
        repo.result = .success(sampleArticles)

        let vm = ArticleViewModel(repository: repo)

        vm.loadArticles()
        vm.search(query: "test")
        vm.search(query: "") // reset

        XCTAssertEqual(vm.numberOfRows(), sampleArticles.count)
    }
    
    func test_loadArticles_returns_cached_data_on_failure() {

        let repo = ArticleRepositoryMock()
        repo.result = .failure(NSError(domain: "", code: -1009)) // no internet
        repo.cached = sampleArticles

        let vm = ArticleViewModel(repository: repo)

        let expectation = XCTestExpectation(description: "cache fallback")

        vm.onStateChange = { state in
            if case .success = state {
                expectation.fulfill()
            }
        }

        vm.loadArticles()

        wait(for: [expectation], timeout: 1.0)

        XCTAssertEqual(vm.numberOfRows(), sampleArticles.count)
    }
    
   
    
}
