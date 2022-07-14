//
//  mvp_exampleTests.swift
//  mvp_exampleTests
//
//  Created by Alvaro Choque on 21/6/22.
//
import XCTest
import UIKit
@testable import mvp_example

class MockPostVC: UIViewController, PostPresenterDelegate {
    var presentAlertGotCalled = false
    var presentPostsGotCalled = false
    
    func presentPosts(posts: [Post]) {
       presentPostsGotCalled = true
    }
    
    func presentAlert(title: String, message: String) {
       presentAlertGotCalled = true
    }
}

class mvp_exampleTests: XCTestCase {
    
    private var postPresenter: PostPresenter!
    override func setUp() {
        super.setUp()
        postPresenter = PostPresenter()
    }

    override func tearDown() {
        postPresenter = nil
        super.tearDown()
    }
    
    func test_set_delegate() {
        let postsViewController = PostsViewController()
        
        postPresenter.setViewDelegate(delegate: postsViewController.self)
        
        XCTAssertTrue(postPresenter.delegate == postsViewController.self)
    }
    

    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    

//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
