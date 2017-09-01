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

    @IBOutlet weak var postTableView: UITableView!

    var posts = [Post]()

    override func viewDidLoad() {
        super.viewDidLoad()
        postTableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        let post1 = Post(topic: "1")
        let post2 = Post(topic: "topic 2 g0bq9fCKfhYbeAAIzXubvZnemCgsn6Xjs3tPiVtmp8nDTLgC3vZzVnkiMCUVOMSDf4raqghyClrbuSAyLDCZbVK6b2c61TPX3l0tevNeIKIyNiKhJZl3SB5tOveas3mhiIvczuvjrdPgV3NJRKzr6My1HyEmrdbM8sOJO6w13pwJMzwdPJWatBDj76MlxILWWptzTN3pKA1LnDeJUBTJFE3xE0nruhUHILoPIlaYm4cXyIq2O2jEjcgqPojL7wy")
        let post3 = Post(topic: "topic 3 g0bq9fCKfhYb")
        let post4 = Post(topic: "topic 4 g0bq9fCKfhYbg0bq9fCKfhYbg0bq9fCKfhYbg0bq9fCKfhYbg0bq9fCKfhYb")

        posts.append(post1)
        posts.append(post2)
        posts.append(post3)
        posts.append(post4)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PostTableViewCell
        cell.topicLabel.text = posts[indexPath.row].topic
        cell.indexPath = indexPath
        cell.delegate = self

        return cell
    }
}

extension ViewController: UITableViewDelegate {

}

// MARK:- Actions
extension ViewController: PostCellDelegate {
    func upvote(indexPath: IndexPath) {

    }

    func downvote(indexPath: IndexPath) {
        
    }
}
