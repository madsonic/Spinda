//
//  UITestsHelpers.swift
//  SpindaUITests
//
//  Created by Gerald on 3/9/17.
//  Copyright © 2017 com.gerald. All rights reserved.
//

import XCTest

class UITestsHelpers {
    open class func tapCreatePostButton() {
        let app = XCUIApplication()
        let addButton = app.navigationBars.buttons[Identifier.createPostButton.rawValue]
        addButton.tap()
    }

    open class func addPost(topic: String = "random topic string") {
        tapCreatePostButton()
        writePost(topic: topic)
        let modal = XCUIApplication().otherElements[Identifier.createPostModal.rawValue]
        modal.buttons[Identifier.confirmCreatePostButton.rawValue].tap()
    }

    open class func cancelPost() {
        tapCreatePostButton()
        let app = XCUIApplication()
        let modal = app.otherElements[Identifier.createPostModal.rawValue]
        let result = wait(for: modal, condition: "isHittable")

        guard result == .completed else {
            XCTFail()
            return
        }

        modal.buttons[Identifier.cancelCreatePostButton.rawValue].tap()
    }

    open class func writePost(topic: String) {
        let app = XCUIApplication()
        let modal = app.otherElements[Identifier.createPostModal.rawValue]
        let result = wait(for: modal, condition: "isHittable")

        guard result == .completed else {
            XCTFail()
            return
        }

        let textView = modal.textViews[Identifier.topicView.rawValue]
        textView.tap()
        textView.typeText(topic)
    }
    /// Wait for some duration for element to meet given condition
    /// Helpful in async testing e.g. wait for ui element animation to complete before proceeding
    /// - Parameters:
    ///   - element: element to wait for
    ///   - condition: condition element holds. Possible values include `isHittable`, `exists`
    ///   - expectation: expectation of condition. Defaults to true
    ///   - timeout: time to wait. Defaults to 1
    /// - Returns: true if `Result` is `.completed`
    open class func wait(for element: XCUIElement, condition: String,
                      toBe expectation: Bool = true, forSeconds timeout: TimeInterval = 1) -> XCTWaiter.Result {
        let expectation = XCTKVOExpectation(keyPath: condition, object: element, expectedValue: expectation)
        return XCTWaiter().wait(for: [expectation], timeout: timeout)
    }
}
