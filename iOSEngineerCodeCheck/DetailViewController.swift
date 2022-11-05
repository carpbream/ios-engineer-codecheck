//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var ownerIconImageView: UIImageView!
    @IBOutlet weak var repositoryNameLabel: UILabel!
    @IBOutlet weak var langageLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var watcherCountLabel: UILabel!
    @IBOutlet weak var forkCountLabel: UILabel!
    @IBOutlet weak var issueCountLabel: UILabel!

    var listViewController: ListViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        let repo = listViewController.repositories[listViewController.index]

        langageLabel.text = "Written in \(repo["language"] as? String ?? "")"
        starCountLabel.text = "\(repo["stargazers_count"] as? Int ?? 0) stars"
        watcherCountLabel.text = "\(repo["wachers_count"] as? Int ?? 0) watchers"
        forkCountLabel.text = "\(repo["forks_count"] as? Int ?? 0) forks"
        issueCountLabel.text = "\(repo["open_issues_count"] as? Int ?? 0) open issues"
        getImage()

    }

    func getImage() {
        let repo = listViewController.repositories[listViewController.index]

        repositoryNameLabel.text = repo["full_name"] as? String

        if let owner = repo["owner"] as? [String: Any] {
            if let ownerIconImageURL = owner["avatar_url"] as? String {
                URLSession.shared.dataTask(with: URL(string: ownerIconImageURL)!) { (data, _, _) in
                    let img = UIImage(data: data!)!
                    DispatchQueue.main.async {
                        self.ownerIconImageView.image = img
                    }
                }.resume()
            }
        }
    }

}
