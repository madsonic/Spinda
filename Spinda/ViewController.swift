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

    let topics = ["1", "123123", "g0bq9fCKfhYbeAAIzXubvZnemCgsn6Xjs3tPiVtmp8nDTLgC3vZzVnkiMCUVOMSDf4raqghyClrbuSAyLDCZbVK6b2c61TPX3l0tevNeIKIyNiKhJZl3SB5tOveas3mhiIvczuvjrdPgV3NJRKzr6My1HyEmrdbM8sOJO6w13pwJMzwdPJWatBDj76MlxILWWptzTN3pKA1LnDeJUBTJFE3xE0nruhUHILoPIlaYm4cXyIq2O2jEjcgqPojL7wy", "g0bq9fCKfhYbeAAIzX"]

    override func viewDidLoad() {
        super.viewDidLoad()
        postTableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PostTableViewCell
        cell.topicLabel.text = topics[indexPath.row]

        return cell
    }
}

extension ViewController: UITableViewDelegate {

}
