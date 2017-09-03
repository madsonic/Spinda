//
//  SpindaCreatePostsUITests.swift
//  SpindaUITests
//
//  Created by Gerald on 3/9/17.
//  Copyright © 2017 com.gerald. All rights reserved.
//

import XCTest

class SpindaCreatePostsUITests: XCTestCase {
    let createPostButtonIdentifer = "createPostButton"
    let createPostModalIdentifer = "createPostModal"
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreatePostModalItShouldBeHiddenOnStart() {
        XCTAssertTrue(!XCUIApplication().otherElements["Create Post Modal"].isHittable, "Create post modal should be hidden on start")
    }

    func testCreatePostModalItShouldBeShownOnAdd() {
        tapAddButton()
        let modal = XCUIApplication().otherElements[createPostModalIdentifer]

        XCTAssertTrue(wait(for: modal, condition: "isHittable"), "Create post modal should show on create post")
    }


    /// Wait for some duration for element to meet given condition
    /// Helpful in async testing e.g. wait for ui element animation to complete before proceeding
    /// - Parameters:
    ///   - element: element to wait for
    ///   - condition: condition element holds. Possible values include `isHittable`, `exists`
    ///   - expectation: expectation of condition. Defaults to true
    ///   - timeout: time to wait. Defaults to 1
    /// - Returns: true if `Result` is `.completed`
    private func wait(for element: XCUIElement, condition: String,
                      toBe expectation: Bool = true, forSeconds timeout: TimeInterval = 1) -> Bool {
        let expectation = XCTKVOExpectation(keyPath: condition, object: element, expectedValue: expectation)
        return XCTWaiter().wait(for: [expectation], timeout: timeout) == .completed
    }

    private func tapAddButton() {
        let app = XCUIApplication()
        let addButton = app.navigationBars.buttons[createPostButtonIdentifer]
        addButton.tap()
    }
}
