//
//  DetailViewPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by 大内麻衣子 on 2022/11/06.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

class DetailViewPresenter: PresenterProtocol {
    typealias ControllerType = DetailViewController
    typealias RouterType = DetailRouter

    weak var controller: DetailViewController?
    var router: DetailRouter

    required init(controller: DetailViewController) {
        self.controller = controller
        self.router = DetailRouter(controller: controller)
    }

    func createLanguageText(for item: Item) -> String {
        guard let language = item.language else {
            return ""
        }

        if language == "" {
            return ""
        } else {
            return "Written in \(language)"
        }
    }

    func createStarCountText(for item: Item) -> String {
        let count = item.stargazers_count < 0 ? 0 : item.stargazers_count
        return "\(count) stars"
    }

    func createWtacherCountText(for item: Item) -> String {
        let count = item.watchers_count < 0 ? 0 : item.watchers_count
        return "\(count) watchers"
    }

    func createForkCountText(for item: Item) -> String {
        let count = item.forks_count < 0 ? 0 : item.forks_count
        return "\(count) forks"
    }

    func createIssuesCountText(for item: Item) -> String {
        let count = item.open_issues_count < 0 ? 0 : item.open_issues_count
        return "\(count) open issues"
    }
}
