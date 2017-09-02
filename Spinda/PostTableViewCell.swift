//
//  PostTableViewCell.swift
//  Spinda
//
//  Created by Gerald on 2/9/17.
//  Copyright © 2017 com.gerald. All rights reserved.
//

import UIKit

protocol PostCellDelegate {
    func upvote(indexPath: IndexPath)
    func downvote(indexPath: IndexPath)
}

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var topic: UILabel!
    @IBOutlet weak var upvoteButton: UIView!
    @IBOutlet weak var downvoteButton: UIView!

    var indexPath: IndexPath!
    var delegate: PostCellDelegate!
}
