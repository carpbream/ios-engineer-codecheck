//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController, UISearchBarDelegate, ControllerProtocol {

    typealias PresenterType = ListViewPresenter

    @IBOutlet weak var searchBar: UISearchBar!

    var presenter: PresenterType?
    var params: Any?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ListViewPresenter(controller: self)
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // 検索バーに入力開始する際、検索バーのテキストを空にする
        searchBar.text = ""
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.cancelLoading()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter?.startLoading(searchBar.text)
    }

    func finishLoading() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.githubRepo?.items.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Repository")
        guard let item = presenter?.getItem(for: indexPath) else {
            return cell
        }
        cell.textLabel?.text = item.full_name
        cell.detailTextLabel?.text = item.language
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セル選択時に呼ばれる
        guard let item = presenter?.getItem(for: indexPath) else {
            return
        }
        presenter?.router.move(to: .DetailViewController, params: item)
    }

}
