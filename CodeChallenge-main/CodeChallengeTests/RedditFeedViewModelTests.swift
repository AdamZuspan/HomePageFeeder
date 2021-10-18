//
//  RedditFeedViewModelTests.swift
//  CodeChallengeTests
//
//  Created by Adam Zuspan on 10/18/21.
//

import XCTest
import Combine
@testable import CodeChallenge

class RedditFeedViewModelTests: XCTestCase {

    var viewModel: RedditFeedViewModel!
    var cancellable: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = RedditFeedViewModel(repository: MockRepository())
        cancellable = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        cancellable = nil
        try super.tearDownWithError()
    }
    
    func testGetFeedDataSuccess() {
        let expectation = XCTestExpectation(description: "Successfully got data")
        viewModel.after = "success"
        
        viewModel?
            .feedBinding
            .dropFirst()
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { _ in
                expectation.fulfill()
            })
            .store(in: &cancellable)
        
        viewModel?
            .errorBinding
            .dropFirst()
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { _ in
                XCTFail()
            })
            .store(in: &cancellable)
        viewModel?.getRedditFeeds()
        wait(for: [expectation], timeout: 3)
        
        XCTAssertEqual(viewModel.numberOfItems, 25)
        XCTAssertEqual(viewModel.getTitle(at: 0), "The Fox has started sleeping regularly next to where the (indoor) kitten sleeps. She purrs like mad whenever the fox is there")
        XCTAssertEqual(viewModel.getCommentNumber(at: 0), "# comment: 551")
        XCTAssertEqual(viewModel.getScore(at: 0), "score: 28432")
    }
    
    func testGetFeedDataFailure() {
        let expectation = XCTestExpectation(description: "Failed to get data")
        viewModel.after = nil
        var error: String?
        
        viewModel?
            .feedBinding
            .dropFirst()
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { _ in
                XCTFail()
            })
            .store(in: &cancellable)
        
        viewModel?
            .errorBinding
            .dropFirst()
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { value in
                error = value
                expectation.fulfill()
            })
            .store(in: &cancellable)
        viewModel?.getRedditFeeds()
        wait(for: [expectation], timeout: 3)
        
        XCTAssertEqual(error, "The operation couldn’t be completed. (CodeChallenge.NetworkError error 1.)")
    }

}
