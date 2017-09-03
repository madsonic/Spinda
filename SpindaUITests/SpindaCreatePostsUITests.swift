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
    let topicViewIdentifer = "topicView"
    let confirmCreatePostButtonIdentifer = "confirmCreatePostButton"
    let cancelCreatePostButtonIdentifer = "cancelCreatePostButton"

    // Limit is 255
    let topic255Long = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quisa"
    let topic256Long = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quisaw"
        
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
        tapCreatePostButton()
        let modal = XCUIApplication().otherElements[createPostModalIdentifer]

        XCTAssertTrue(wait(for: modal, condition: "isHittable") == .completed, "Create post modal should show on create post")
    }

    func testCreatePostItShouldAddNewPost() {
        addPost()
        let newPost = XCUIApplication().tables.cells.element(boundBy: 0)

        XCTAssertTrue(newPost.exists, "Post not created")
    }

    func testTextViewTextAfterCreatePostItShouldBeEmpty() {
        addPost()
        let textView = XCUIApplication().otherElements[createPostModalIdentifer].textViews[topicViewIdentifer]

        XCTAssertEqual(textView.value as! String, "", "Text view not cleared after creating post")
    }

    func testTextViewTextAfterCancelItShouldBeEmpty() {
        tapCreatePostButton()
        writePost(topic: "random topic string")
        let modal = XCUIApplication().otherElements[createPostModalIdentifer]
        modal.buttons[cancelCreatePostButtonIdentifer].tap()

        let textView = modal.textViews[topicViewIdentifer]
        XCTAssertEqual(textView.value as! String, "", "Text view not cleared after creating post")
    }

    func testCreatePostModalVisiblityAfterCreateItShouldBeHidden() {
        addPost()
        let modal = XCUIApplication().otherElements[createPostModalIdentifer]

        XCTAssertTrue(!modal.isHittable, "Create post modal should be hidden after create")
    }

    func testCreatePostModalVisiblityAfterCancelItShouldBeHidden() {
        cancelPost()
        let modal = XCUIApplication().otherElements[createPostModalIdentifer]

        XCTAssertTrue(!modal.isHittable, "Create post modal should be hidden after cancel")
    }

    func testTopicLengthUnderLimitItShouldBeCreated() {
        tapCreatePostButton()
        addPost(topic: topic255Long)

        let modal = XCUIApplication().otherElements[createPostModalIdentifer]

        guard wait(for: modal, condition: "isHittable", toBe: false) == .completed else {
            XCTFail()
            return
        }

        let newPost = XCUIApplication().tables.cells.element(boundBy: 0)
        XCTAssertTrue(newPost.exists, "Post with topic under character limit not created")
    }

    func testTopicLengthOverLimitItShouldNotBeCreated() {
        tapCreatePostButton()
        addPost(topic: topic256Long)
        let newPost = XCUIApplication().tables.cells.element(boundBy: 0)

        XCTAssertTrue(!newPost.exists, "Post with topic over character limit created")
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
                      toBe expectation: Bool = true, forSeconds timeout: TimeInterval = 1) -> XCTWaiter.Result {
        let expectation = XCTKVOExpectation(keyPath: condition, object: element, expectedValue: expectation)
        return XCTWaiter().wait(for: [expectation], timeout: timeout)
    }

    private func tapCreatePostButton() {
        let app = XCUIApplication()
        let addButton = app.navigationBars.buttons[createPostButtonIdentifer]
        addButton.tap()
    }

    private func addPost(topic: String = "random topic string") {
        tapCreatePostButton()
        writePost(topic: topic)
        let modal = XCUIApplication().otherElements[createPostModalIdentifer]
        modal.buttons[confirmCreatePostButtonIdentifer].tap()
    }

    private func cancelPost() {
        tapCreatePostButton()
        let app = XCUIApplication()
        let modal = app.otherElements[createPostModalIdentifer]
        let result = wait(for: modal, condition: "isHittable")

        guard result == .completed else {
            XCTFail()
            return
        }

        modal.buttons[cancelCreatePostButtonIdentifer].tap()
    }

    private func writePost(topic: String) {
        let app = XCUIApplication()
        let modal = app.otherElements[createPostModalIdentifer]
        let result = wait(for: modal, condition: "isHittable")

        guard result == .completed else {
            XCTFail()
            return
        }

        let textView = modal.textViews[topicViewIdentifer]
        textView.tap()
        textView.typeText(topic)
    }
}
