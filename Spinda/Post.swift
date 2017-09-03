//
//  Post.swift
//  Spinda
//
//  Created by Gerald on 1/9/17.
//  Copyright © 2017 com.gerald. All rights reserved.
//

struct Post {
    let topic: String
    let maxTopicLength = 255
    private(set) var upvotes: Int = 0
    private(set) var downvotes: Int = 0

    init?(topic: String) {
        guard topic.count <= maxTopicLength else {
            return nil
        }
        self.topic = topic
    }

    mutating func changeUpvoteCount(by count: Int = 1) {
        upvotes += count
    }

    mutating func changeDownvoteCount(by count: Int = 1) {
        downvotes += count
    }
}
