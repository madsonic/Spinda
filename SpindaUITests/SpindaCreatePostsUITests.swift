//
//  SpindaCreatePostsUITests.swift
//  SpindaUITests
//
//  Created by Gerald on 3/9/17.
//  Copyright © 2017 com.gerald. All rights reserved.
//

import XCTest

class SpindaCreatePostsUITests: XCTestCase {
    // Limit is 255
    let topic255Long = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quisa"
    let topic256Long = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quisaw"
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCreatePostModalItShouldBeHiddenOnStart() {
        XCTAssertTrue(!XCUIApplication().otherElements[Identifier.createPostModal.rawValue].isHittable,
                      "Create post modal should be hidden on start")
    }

    func testCreatePostModalItShouldBeShownOnAdd() {
        UITestsHelpers.tapCreatePostButton()
        let modal = XCUIApplication().otherElements[Identifier.createPostModal.rawValue]

        XCTAssertTrue(UITestsHelpers.wait(for: modal, condition: "isHittable") == .completed,
                      "Create post modal should show on create post")
    }

    func testCreatePostItShouldAddNewPost() {
        UITestsHelpers.addPost()
        let newPost = XCUIApplication().tables.cells.element(boundBy: 0)

        XCTAssertTrue(newPost.exists, "Post not created")
    }

    func testTextViewTextAfterCreatePostItShouldBeEmpty() {
        UITestsHelpers.addPost()
        let textView = XCUIApplication().otherElements[Identifier.createPostModal.rawValue]
            .textViews[Identifier.topicView.rawValue]

        XCTAssertEqual(textView.value as! String, "", "Text view not cleared after creating post")
    }

    func testTextViewTextAfterCancelItShouldBeEmpty() {
        UITestsHelpers.tapCreatePostButton()
        UITestsHelpers.writePost(topic: "random topic string")
        let modal = XCUIApplication().otherElements[Identifier.createPostModal.rawValue]
        modal.buttons[Identifier.cancelCreatePostButton.rawValue].tap()

        let textView = modal.textViews[Identifier.topicView.rawValue]
        XCTAssertEqual(textView.value as! String, "", "Text view not cleared after creating post")
    }

    func testCreatePostModalVisiblityAfterCreateItShouldBeHidden() {
        UITestsHelpers.addPost()
        let modal = XCUIApplication().otherElements[Identifier.createPostModal.rawValue]

        XCTAssertTrue(!modal.isHittable, "Create post modal should be hidden after create")
    }

    func testCreatePostModalVisiblityAfterCancelItShouldBeHidden() {
        UITestsHelpers.cancelPost()
        let modal = XCUIApplication().otherElements[Identifier.createPostModal.rawValue]

        XCTAssertTrue(!modal.isHittable, "Create post modal should be hidden after cancel")
    }

    func testTopicLengthUnderLimitItShouldBeCreated() {
        UITestsHelpers.tapCreatePostButton()
        UITestsHelpers.addPost(topic: topic255Long)

        let modal = XCUIApplication().otherElements[Identifier.createPostModal.rawValue]

        guard UITestsHelpers.wait(for: modal, condition: "isHittable", toBe: false) == .completed else {
            XCTFail()
            return
        }

        let newPost = XCUIApplication().tables.cells.element(boundBy: 0)
        XCTAssertTrue(newPost.exists, "Post with topic under character limit not created")
    }

    func testTextViewCharLimitItShouldTruncatePast255Char() {
        UITestsHelpers.tapCreatePostButton()
        UIPasteboard.general.string = topic256Long

        let app = XCUIApplication()
        let modal = app.otherElements[Identifier.createPostModal.rawValue]
        let result = UITestsHelpers.wait(for: modal, condition: "isHittable")

        guard result == .completed else {
            XCTFail()
            return
        }

        let textView = modal.textViews[Identifier.topicView.rawValue]
        textView.doubleTap()

        let pasteMenuItem = app.menuItems.element(boundBy: 0)
        pasteMenuItem.tap()

        sleep(2) // wait does not work paste

        let textViewValue = textView.value as! String

        XCTAssertEqual(textViewValue.count, topic255Long.count,
                       "Post with topic over character limit created")
    }

    func testPostTableItShouldHaveNoPosts() {
        let newPost = XCUIApplication().tables.cells.element(boundBy: 0)

        XCTAssertTrue(!newPost.exists, "Post with topic over character limit created")
    }

}


