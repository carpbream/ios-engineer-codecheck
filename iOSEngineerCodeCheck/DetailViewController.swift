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

    weak var listViewController: ListViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let listViewController = self.listViewController else {
            print("ListViewController is not loaded.")
            DispatchQueue.main.async {
                self.dismiss(animated: true)
            }
            return
        }

        guard let idx = listViewController.index else {
            print("ERROR: listViewController.index is not set.")
            DispatchQueue.main.async {
                self.dismiss(animated: true)
            }
            return
        }

        if listViewController.repositories.count <= idx {
            print("ERROR: repository index exceeds the number of count.")
            DispatchQueue.main.async {
                self.dismiss(animated: true)
            }
            return
        }

        let repo = listViewController.repositories[idx]

        langageLabel.text = "Written in \(repo["language"] as? String ?? "")"
        starCountLabel.text = "\(repo["stargazers_count"] as? Int ?? 0) stars"
        watcherCountLabel.text = "\(repo["watchers_count"] as? Int ?? 0) watchers"
        forkCountLabel.text = "\(repo["forks_count"] as? Int ?? 0) forks"
        issueCountLabel.text = "\(repo["open_issues_count"] as? Int ?? 0) open issues"
        getImage(repository: repo)

    }

    func getImage(repository: [String: Any]) {

        if repository.keys.contains("full_name") {
            repositoryNameLabel.text = repository["full_name"] as? String
        }

        guard let owner = repository["owner"] as? [String: Any] else {
            print("ERROR: owner in repository is not set.")
            return
        }

        guard let ownerIconImageURL = owner["avatar_url"] as? String else {
            print("ERROR: owner in repository is not set.")
            return
        }

        Task {
            do {
                let apiClient = APIClient()
                let data = try await apiClient.request(with: ownerIconImageURL)
                guard let image = UIImage(data: data) else {
                    print("ERROR: invalid data. data: \(data.description)")
                    return
                }
                
                DispatchQueue.main.async {
                    self.ownerIconImageView.image = image
                }
            } catch {
                print("ERROR: \(error.localizedDescription)")
            }
        }
    }

}
