//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!

    var repositories: [[String: Any]] = []
    var urlSessionTask: URLSessionTask?
    var searchWard: String = ""
    var urlString: String = ""
    var index: Int? = 0

    var detailViewController: DetailViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // 検索バーに入力開始する際、検索バーのテキストを空にする
        searchBar.text = ""
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        urlSessionTask?.cancel()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else {
            print("ERROR: search word is not set.")
            return
        }

        if searchBarText == "" {
            print("ERROR: search word is not set.")
            return
        }

        searchWard = searchBarText

        Task {
            urlString = "https://api.github.com/search/repositories?q=\(searchWard)"

            do {
                let apiClient = APIClient()
                let data = try await apiClient.request(with: urlString)
                guard let jsonObj = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("ERROR: データの形式が不正です")
                    return
                }

                guard let items = jsonObj["items"] as? [[String: Any]] else {
                    print("ERROR: データの形式が不正です")
                    return
                }

                self.repositories = items
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail", let detailViewController = segue.destination as? DetailViewController {
            detailViewController.listViewController = self
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Repository")

        if repositories.count <= indexPath.row {
            print("ERROR: repository index exceeds the number of count")
            return cell
        }

        let repository = repositories[indexPath.row]
        cell.textLabel?.text = repository["full_name"] as? String
        cell.detailTextLabel?.text = repository["language"] as? String
        cell.tag = indexPath.row
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セル選択時に呼ばれる
        index = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
    }

}
