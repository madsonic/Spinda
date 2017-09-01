//
//  Post.swift
//  Spinda
//
//  Created by Gerald on 1/9/17.
//  Copyright © 2017 com.gerald. All rights reserved.
//

struct Post {
    let topic: String
    var upvote: Int = 0
    var downvote: Int = 0

    init(topic: String) {
        self.topic = topic
    }
}
