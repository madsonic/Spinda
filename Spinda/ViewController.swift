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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    }
}

extension ViewController: UITableViewDelegate {

}
