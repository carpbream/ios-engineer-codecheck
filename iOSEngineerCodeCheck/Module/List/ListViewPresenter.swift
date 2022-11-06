//
//  ListViewPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by 大内麻衣子 on 2022/11/06.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

class ListViewPresenter: PresenterProtocol {
    typealias ControllerType = ListViewController
    typealias RouterType = ListViewRouter

    weak var controller: ListViewController?
    var router: ListViewRouter
    var downloadTask: Task<(), Never>?
    var githubRepo: GithubRepo?

    required init(controller: ListViewController) {
        self.controller = controller
        self.router = ListViewRouter(controller: controller)
    }

    func cancelLoading() {
        self.downloadTask?.cancel()
    }

    func startLoading(_ searchText: String?) {
        guard let text = searchText, !text.isEmpty else {
            print("ERROR: 文字列が入力されていません")
            return
        }

        let interactor = GithubRepoRepository()
        downloadTask = Task {
            do {
                self.githubRepo = try await interactor.getGithubRepositories(for: text)
                await self.controller?.finishLoading()
            } catch {
                print("ERROR: \(error.localizedDescription)")
            }
        }
    }

    func getItem(for indexPath: IndexPath) -> Item? {
        guard let items = githubRepo?.items else {
            print("ERROR: データが存在しません")
            return nil
        }

        if items.count <= indexPath.row {
            print("ERROR: 指定されたインデックスはitemsのカウントを超えています")
            return nil
        }

        return items[indexPath.row]
    }
}
