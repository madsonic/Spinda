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

    @IBOutlet weak var postTableView: UITableView!
    @IBOutlet weak var modalXConstraint: NSLayoutConstraint!
    @IBOutlet weak var topicView: UITextView!
    @IBOutlet weak var createPostModalView: UIView!
    @IBOutlet weak var characterCount: UILabel!

    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let post1 = Post(topic: "1")
        let post2 = Post(topic: "topic 2 g0bq9fCKfhYbeAAIzXubvZnemCgsn6Xjs3tPiVtmp8nDTLgC3vZzVnkiMCUVOMSDf4raqghyClrbuSAyLDCZbVK6b2c61TPX3l0tevNeIKIyNiKhJZl3SB5tOveas3mhiIvczuvjrdPgV3NJRKzr6My1HyEmrdbM8sOJO6w13pwJMzwdPJWatBDj76MlxILWWptzTN3pKA1LnDeJUBTJFE3xE0nruhUHILoPIlaYm4cXyIq2O2jEjcgqPojL7wy")
        let post3 = Post(topic: "topic 3 g0bq9fCKfhYb")
        let post4 = Post(topic: "topic 4 g0bq9fCKfhYbg0bq9fCKfhYbg0bq9fCKfhYbg0bq9fCKfhYbg0bq9fCKfhYb")

        posts.append(post1)
        posts.append(post2)
        posts.append(post3)
        posts.append(post4)

        setupCreatePostModal()
    }

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

        closeCreatePostModal()
        let post = Post(topic: topic)
        posts.append(post)
        postTableView.reloadData()
        topicView.text = ""
    }

    @IBAction func cancelCreatePost(_ sender: UIButton) {
        closeCreatePostModal()
        topicView.text = ""
    }

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
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PostTableViewCell
        cell.topic.text = posts[indexPath.row].topic
        cell.indexPath = indexPath
        cell.delegate = self

//        cell.upvoteButton.titleLabel?.text = String(posts[indexPath.row].upvotes)
//        cell.downvoteButton.titleLabel?.text = String(posts[indexPath.row].downvotes)

        return cell
    }
}

extension ViewController: UITableViewDelegate {

}

// MARK:- PostCellDelegate
extension ViewController: PostCellDelegate {
    func upvote(indexPath: IndexPath) {
        posts[indexPath.row].changeUpvoteCount()
        postTableView.reloadRows(at: [indexPath], with: .none)
    }

    func downvote(indexPath: IndexPath) {
        posts[indexPath.row].changeDownvoteCount()
        postTableView.reloadRows(at: [indexPath], with: .none)
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
