//
//  SpindaUITests.swift
//  SpindaUITests
//
//  Created by Gerald on 1/9/17.
//  Copyright © 2017 com.gerald. All rights reserved.
//

import XCTest

class SpindaVoteButtonsUITests: XCTestCase {
    let upvoteButtonIdentifier = "upvoteButton"
    let downvoteButtonIdentifier = "downvoteButton"
        
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
    
    func testDownvotesButtonByTappingTwiceItShouldIncreaseByN() {
        let app = XCUIApplication()
        let downvoteButton = app.tables.cells.element(boundBy: 0).buttons[downvoteButtonIdentifier]
        let tapCount = 2
        for _ in 0..<tapCount {
            downvoteButton.tap()
        }

        XCTAssertEqual(Int(downvoteButton.label), tapCount, "Downvote count did not increase by \(tapCount)")
    }

    func testDownvotesButtonByDoingNothingItShouldNotChange() {
        let app = XCUIApplication()
        let downvoteButton = app.tables.cells.element(boundBy: 0).buttons[downvoteButtonIdentifier]

        XCTAssertEqual(Int(downvoteButton.label), 0, "Downvote count changed")
    }

    func testUpvotesButtonByTappingTwiceItShouldIncreaseByN() {
        let app = XCUIApplication()
        let upvoteButton = app.tables.cells.element(boundBy: 0).buttons[upvoteButtonIdentifier]
        let tapCount = 2
        for _ in 0..<tapCount {
            upvoteButton.tap()
        }

        XCTAssertEqual(Int(upvoteButton.label), tapCount, "Upvote count did not increase by \(tapCount)")
    }

    func testUpvotesButtonByDoingNothingItShouldNotChange() {
        let app = XCUIApplication()
        let upvoteButton = app.tables.cells.element(boundBy: 0).buttons[upvoteButtonIdentifier]

        XCTAssertEqual(Int(upvoteButton.label), 0, "Upvote count changed")
    }

    func testPostOrderingByUpvotingSecondPostItShouldRiseOneSpotHigher() {
        let app = XCUIApplication()
        // TODO: find some way to add in stub post

        let postOne = app.tables.cells.element(boundBy: 0)
        let postTwo = app.tables.cells.element(boundBy: 1)
        postTwo.buttons[upvoteButtonIdentifier].tap()
        let newPostOne = app.tables.cells.element(boundBy: 0)
        let newPostTwo = app.tables.cells.element(boundBy: 1)

        XCTAssertEqual(postTwo.label, newPostOne.label, "Post two should rise in ordering")
        XCTAssertEqual(postOne.label, newPostTwo.label, "Post two should rise in ordering")
    }

    func testPostOrderingByUpvotingHighestPostItShouldRemain() {
        let app = XCUIApplication()
        // TODO: find some way to add in stub post

        let postOne = app.tables.cells.element(boundBy: 0)
        postOne.buttons[upvoteButtonIdentifier].tap()
        let newPostOne = app.tables.cells.element(boundBy: 0)

        XCTAssertEqual(postOne.label, newPostOne.label, "Post one should remain highest ranked")
    }

    func testPostOrderingByUpvotingFirstTwoPostsItShouldRemain() {
        let app = XCUIApplication()
        // TODO: find some way to add in stub post

        let postOne = app.tables.cells.element(boundBy: 0)
        let postTwo = app.tables.cells.element(boundBy: 1)
        postOne.buttons[upvoteButtonIdentifier].tap()
        postTwo.buttons[upvoteButtonIdentifier].tap()
        let newPostOne = app.tables.cells.element(boundBy: 0)
        let newPostTwo = app.tables.cells.element(boundBy: 1)

        XCTAssertEqual(postOne.label, newPostOne.label, "Post one should remain highest ranked")
        XCTAssertEqual(postTwo.label, newPostTwo.label, "Post two is tied with first. Post two should remain second")
    }

    func testPostOrderingWithNoActionItShouldRemain() {
        let app = XCUIApplication()
        // TODO: find some way to add in stub post

        let postOne = app.tables.cells.element(boundBy: 0)
        let postTwo = app.tables.cells.element(boundBy: 1)
        let newPostOne = app.tables.cells.element(boundBy: 0)
        let newPostTwo = app.tables.cells.element(boundBy: 1)

        XCTAssertEqual(postOne.label, newPostOne.label, "Post one should remain")
        XCTAssertEqual(postTwo.label, newPostTwo.label, "Post two shoudl remain")
    }
}
