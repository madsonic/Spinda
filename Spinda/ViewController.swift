//
//  ViewController.swift
//  Spinda
//
//  Created by Gerald on 1/9/17.
//  Copyright © 2017 com.gerald. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let cellIdentifier = "topicCellIdentifier"
    let initialModalXPosition: CGFloat = -500
    let finalModalXPosition: CGFloat = 0
    let maxCharCount = 100
    let maxPostsDisplayed = 20

    @IBOutlet weak var postTableView: UITableView!
    @IBOutlet weak var modalXConstraint: NSLayoutConstraint!
    @IBOutlet weak var topicView: UITextView!
    @IBOutlet weak var createPostModalView: UIView!
    @IBOutlet weak var characterCount: UILabel!

    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let post1 = Post(topic: "topic 1"),
            let post2 = Post(topic: "topic 2 g0bq9fCKfhYbeAAIzXubvZnemCgsn6Xjs3tPiVtmpA1LnDeJUBTJFE3xE0nruhUHILoPIlaYm4cXyIq2O2jEjcgqPojL7wy"),
            let post3 = Post(topic: "topic 3 g0bq9fCKfhYb"),
            let post4 = Post(topic: "topic 4 g0bq9fCKfhYbg0bq9fCKfhYbg0bq9fCKfhYbg0bq9fCKfhYbg0bq9fCKfhYb") else {
            return
        }

        posts.append(post1)
        posts.append(post2)
        posts.append(post3)
        posts.append(post4)

        setupCreatePostModal()
    }

    //MARK:- Actions
    @IBAction func showCreatePostModal(_ sender: UIBarButtonItem) {
        modalXConstraint.constant = finalModalXPosition

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func createPost(_ sender: UIButton) {
        // close popup
        // add to data structure
        guard let topic = topicView.text, !topicView.text.isEmpty else {
            return
        }


        guard let post = Post(topic: topic) else {
            return
        }

        posts.append(post)
        closeCreatePostModal()
        postTableView.reloadData()
        topicView.text = ""
    }

    @IBAction func cancelCreatePost(_ sender: UIButton) {
        closeCreatePostModal()
        topicView.text = ""
    }

    @IBAction func upvote(_ sender: UIButton) {
        posts[sender.tag].changeUpvoteCount()
        sender.setTitle(String(posts[sender.tag].upvotes), for: .normal)

        // Float post 1 position higher if necessary
        let postRank = sender.tag
        guard postRank != 0 else {
            return
        }

        let postUpvotes = posts[postRank].upvotes
        let hotterPostUpvotes = posts[postRank - 1].upvotes

        if postUpvotes > hotterPostUpvotes {
            posts.swapAt(postRank, postRank - 1)
            let indexPaths = [IndexPath(row: postRank, section: 0), IndexPath(row: postRank - 1, section: 0)]
            postTableView.reloadRows(at: indexPaths, with: .fade)
        }

    }

    @IBAction func downvote(_ sender: UIButton) {
        posts[sender.tag].changeDownvoteCount()
        sender.setTitle(String(posts[sender.tag].upvotes), for: .normal)
    }

    // MARK:- Private methods
    private func closeCreatePostModal() {
        modalXConstraint.constant = initialModalXPosition

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    private func setupCreatePostModal() {
        createPostModalView.layer.cornerRadius = 10
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(maxPostsDisplayed, posts.count)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PostTableViewCell
        cell.topic.text = posts[indexPath.row].topic
        cell.upvoteButton.tag = indexPath.row
        cell.downvoteButton.tag = indexPath.row

        cell.upvoteButton.setTitle(String(posts[indexPath.row].upvotes), for: .normal)
        cell.downvoteButton.setTitle(String(posts[indexPath.row].downvotes), for: .normal)

        return cell
    }
}

// MARK:- TextViewDelegate
extension ViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updateCharCount(textView: textView)
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let modifiedString = textView.text + text

        guard modifiedString.count > maxCharCount else {
            return true
        }

        textView.text = String(modifiedString.prefix(maxCharCount))
        updateCharCount(textView: textView)

        return false
    }

    private func updateCharCount(textView: UITextView) {
        characterCount.text = "\(textView.text.count)/\(maxCharCount)"
    }
}
