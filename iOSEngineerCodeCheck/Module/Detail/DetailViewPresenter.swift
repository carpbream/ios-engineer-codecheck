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
        let lang = item.language ?? ""
        return "Written in \(lang)"
    }

    func createStarCountText(for item: Item) -> String {
        return "\(item.stargazers_count) stars"
    }

    func createWtacherCountText(for item: Item) -> String {
        return "\(item.watchers_count) watchers"
    }

    func createForkCountText(for item: Item) -> String {
        return "\(item.forks_count) forks"
    }

    func createIssuesCountText(for item: Item) -> String {
        return "\(item.open_issues_count) open issues"
    }
}
