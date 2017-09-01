//
//  PostTableViewCell.swift
//  Spinda
//
//  Created by Gerald on 1/9/17.
//  Copyright © 2017 com.gerald. All rights reserved.
//

import UIKit

protocol PostCellDelegate {
    func upvote(indexPath: IndexPath)
    func downvote(indexPath: IndexPath)
}

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var upvoteButton: UIButton!
    @IBOutlet weak var downvoteButton: UIButton!

    var indexPath: IndexPath!
    var delegate: PostCellDelegate!

    @IBAction func upvote(_ sender: UIButton) {
        delegate.upvote(indexPath: indexPath)
    }

    @IBAction func downvote(_ sender: UIButton) {
        delegate.downvote(indexPath: indexPath)
    }
}

