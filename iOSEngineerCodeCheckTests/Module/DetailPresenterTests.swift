//
//  DetailPresenterTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 大内麻衣子 on 2022/11/10.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit
import XCTest
@testable import iOSEngineerCodeCheck

final class DetailPresenterTests: XCTestCase {

    var presenter: DetailViewPresenter?

    override func setUpWithError() throws {

        // presenterを作成
        let vcName = Destination.DetailViewController.rawValue
        let storyBoard = UIStoryboard(name: vcName, bundle: nil)
        guard let controller: DetailViewController = storyBoard.instantiateInitialViewController() else {

            XCTFail("\(vcName)が取得できません")
            return
        }

        presenter = DetailViewPresenter(controller: controller)
    }

    override func tearDownWithError() throws {}

    func testCreateLanguageText() throws {
        XCTContext.runActivity(named: "langage = swift") { _ in
            let resource = "github_repo_language_swift"
            guard let item = getItem(resource: resource) else {
                XCTFail("itemが作成できません resource: \(resource)")
                return
            }

            guard let presenter = self.presenter else {
                XCTFail("presenterがnilです")
                return
            }

            let result = presenter.createLanguageText(for: item)
            XCTAssertEqual(result, "Written in swift")
        }

        XCTContext.runActivity(named: "langage = C#, C++ and 👍") { _ in
            let resource = "github_repo_language_c#_c++_emoji"
            guard let item = getItem(resource: resource) else {
                XCTFail("itemが作成できません resource: \(resource)")
                return
            }

            guard let presenter = self.presenter else {
                XCTFail("presenterがnilです")
                return
            }

            let result = presenter.createLanguageText(for: item)
            XCTAssertEqual(result, "Written in C#, C++ and 👍")
        }

        XCTContext.runActivity(named: "langage = (空文字列)") { _ in
            let resource = "github_repo_language_empty"
            guard let item = getItem(resource: resource) else {
                XCTFail("itemが作成できません resource: \(resource)")
                return
            }

            guard let presenter = self.presenter else {
                XCTFail("presenterがnilです")
                return
            }

            let result = presenter.createLanguageText(for: item)
            XCTAssertEqual(result, "")
        }

        XCTContext.runActivity(named: "langage = (nil)") { _ in
            let resource = "github_repo_language_nil"
            guard let item = getItem(resource: resource) else {
                XCTFail("itemが作成できません resource: \(resource)")
                return
            }

            guard let presenter = self.presenter else {
                XCTFail("presenterがnilです")
                return
            }

            let result = presenter.createLanguageText(for: item)
            XCTAssertEqual(result, "")
        }
    }

    func testCreateStarCountText() throws {
        XCTContext.runActivity(named: "stargazers_count = 0") { _ in
            let resource = "github_repo_stargazers_count_0"
            guard let item = getItem(resource: resource) else {
                XCTFail("itemが作成できません resource: \(resource)")
                return
            }

            guard let presenter = self.presenter else {
                XCTFail("presenterがnilです")
                return
            }

            let result = presenter.createStarCountText(for: item)
            XCTAssertEqual(result, "0 stars")
        }

        XCTContext.runActivity(named: "stargazers_count = 1") { _ in
            let resource = "github_repo_stargazers_count_1"
            guard let item = getItem(resource: resource) else {
                XCTFail("itemが作成できません resource: \(resource)")
                return
            }

            guard let presenter = self.presenter else {
                XCTFail("presenterがnilです")
                return
            }

            let result = presenter.createStarCountText(for: item)
            XCTAssertEqual(result, "1 stars")
        }

        XCTContext.runActivity(named: "stargazers_count = -1") { _ in
            let resource = "github_repo_stargazers_count_-1"
            guard let item = getItem(resource: resource) else {
                XCTFail("itemが作成できません resource: \(resource)")
                return
            }

            guard let presenter = self.presenter else {
                XCTFail("presenterがnilです")
                return
            }

            let result = presenter.createStarCountText(for: item)
            XCTAssertEqual(result, "0 stars")
        }

        XCTContext.runActivity(named: "stargazers_count = Int.max") { _ in
            let resource = "github_repo_stargazers_count_int_max"
            guard let item = getItem(resource: resource) else {
                XCTFail("itemが作成できません resource: \(resource)")
                return
            }

            guard let presenter = self.presenter else {
                XCTFail("presenterがnilです")
                return
            }

            let result = presenter.createStarCountText(for: item)
            XCTAssertEqual(result, "9223372036854775807 stars")
        }

        // Int.maxを超える値を含むデータはGithubRepoオブジェクトを作成できないのでここではテストしない
    }

    func testCreateWatcherCountText() throws {
        XCTContext.runActivity(named: "watchers_count = 0") { _ in
            let resource = "github_repo_watchers_count_0"
            guard let item = getItem(resource: resource) else {
                XCTFail("itemが作成できません resource: \(resource)")
                return
            }

            guard let presenter = self.presenter else {
                XCTFail("presenterがnilです")
                return
            }

            let result = presenter.createWtacherCountText(for: item)
            XCTAssertEqual(result, "0 watchers")
        }

        XCTContext.runActivity(named: "watchers_count = 1") { _ in
            let resource = "github_repo_watchers_count_1"
            guard let item = getItem(resource: resource) else {
                XCTFail("itemが作成できません resource: \(resource)")
                return
            }

            guard let presenter = self.presenter else {
                XCTFail("presenterがnilです")
                return
            }

            let result = presenter.createWtacherCountText(for: item)
            XCTAssertEqual(result, "1 watchers")
        }

        XCTContext.runActivity(named: "watchers_count = -1") { _ in
            let resource = "github_repo_watchers_count_-1"
            guard let item = getItem(resource: resource) else {
                XCTFail("itemが作成できません resource: \(resource)")
                return
            }

            guard let presenter = self.presenter else {
                XCTFail("presenterがnilです")
                return
            }

            let result = presenter.createWtacherCountText(for: item)
            XCTAssertEqual(result, "0 watchers")
        }

        XCTContext.runActivity(named: "watchers_count = Int.max") { _ in
            let resource = "github_repo_watchers_count_int_max"
            guard let item = getItem(resource: resource) else {
                XCTFail("itemが作成できません resource: \(resource)")
                return
            }

            guard let presenter = self.presenter else {
                XCTFail("presenterがnilです")
                return
            }

            let result = presenter.createWtacherCountText(for: item)
            XCTAssertEqual(result, "9223372036854775807 watchers")
        }

        // Int.maxを超える値を含むデータはGithubRepoオブジェクトを作成できないのでここではテストしない
    }

    func testCreateForkCountText() throws {
        XCTContext.runActivity(named: "forks_count = 0") { _ in
            let resource = "github_repo_forks_count_0"
            guard let item = getItem(resource: resource) else {
                XCTFail("itemが作成できません resource: \(resource)")
                return
            }

            guard let presenter = self.presenter else {
                XCTFail("presenterがnilです")
                return
            }

            let result = presenter.createForkCountText(for: item)
            XCTAssertEqual(result, "0 forks")
        }

        XCTContext.runActivity(named: "forks_count = 1") { _ in
            let resource = "github_repo_forks_count_1"
            guard let item = getItem(resource: resource) else {
                XCTFail("itemが作成できません resource: \(resource)")
                return
            }

            guard let presenter = self.presenter else {
                XCTFail("presenterがnilです")
                return
            }

            let result = presenter.createForkCountText(for: item)
            XCTAssertEqual(result, "1 forks")
        }

        XCTContext.runActivity(named: "forks_count = -1") { _ in
            let resource = "github_repo_forks_count_-1"
            guard let item = getItem(resource: resource) else {
                XCTFail("itemが作成できません resource: \(resource)")
                return
            }

            guard let presenter = self.presenter else {
                XCTFail("presenterがnilです")
                return
            }

            let result = presenter.createForkCountText(for: item)
            XCTAssertEqual(result, "0 forks")
        }

        XCTContext.runActivity(named: "forks_count = Int.max") { _ in
            let resource = "github_repo_forks_count_int_max"
            guard let item = getItem(resource: resource) else {
                XCTFail("itemが作成できません resource: \(resource)")
                return
            }

            guard let presenter = self.presenter else {
                XCTFail("presenterがnilです")
                return
            }

            let result = presenter.createForkCountText(for: item)
            XCTAssertEqual(result, "9223372036854775807 forks")
        }

        // Int.maxを超える値を含むデータはGithubRepoオブジェクトを作成できないのでここではテストしない
    }

    func testCreateIssueCountText() throws {
        XCTContext.runActivity(named: "open_issues_count = 0") { _ in
            let resource = "github_repo_open_issues_count_0"
            guard let item = getItem(resource: resource) else {
                XCTFail("itemが作成できません resource: \(resource)")
                return
            }

            guard let presenter = self.presenter else {
                XCTFail("presenterがnilです")
                return
            }

            let result = presenter.createIssuesCountText(for: item)
            XCTAssertEqual(result, "0 open issues")
        }

        XCTContext.runActivity(named: "open_issues_count = 1") { _ in
            let resource = "github_repo_open_issues_count_1"
            guard let item = getItem(resource: resource) else {
                XCTFail("itemが作成できません resource: \(resource)")
                return
            }

            guard let presenter = self.presenter else {
                XCTFail("presenterがnilです")
                return
            }

            let result = presenter.createIssuesCountText(for: item)
            XCTAssertEqual(result, "1 open issues")
        }

        XCTContext.runActivity(named: "open_issues_count = -1") { _ in
            let resource = "github_repo_open_issues_count_-1"
            guard let item = getItem(resource: resource) else {
                XCTFail("itemが作成できません resource: \(resource)")
                return
            }

            guard let presenter = self.presenter else {
                XCTFail("presenterがnilです")
                return
            }

            let result = presenter.createIssuesCountText(for: item)
            XCTAssertEqual(result, "0 open issues")
        }

        XCTContext.runActivity(named: "open_issues_count = Int.max") { _ in
            let resource = "github_repo_open_issues_count_int_max"
            guard let item = getItem(resource: resource) else {
                XCTFail("itemが作成できません resource: \(resource)")
                return
            }

            guard let presenter = self.presenter else {
                XCTFail("presenterがnilです")
                return
            }

            let result = presenter.createIssuesCountText(for: item)
            XCTAssertEqual(result, "9223372036854775807 open issues")
        }

        // Int.maxを超える値を含むデータはGithubRepoオブジェクトを作成できないのでここではテストしない
    }

    func testPerformanceCreateLanguageText() throws {
        self.measure {
            let resource = "github_repo_language_swift"
            guard let item = getItem(resource: resource) else {
                XCTFail("itemが作成できません resource: \(resource)")
                return
            }

            guard let presenter = self.presenter else {
                XCTFail("presenterがnilです")
                return
            }

            let result = presenter.createLanguageText(for: item)
            XCTAssertEqual(result, "Written in swift")
        }
    }

    func getItem(resource: String) -> Item? {
        // itemを作成
        do {
            let bundle = Bundle(for: type(of: self))
            let githubRepo: GithubRepo = try bundle.object(for: resource)
            return githubRepo.items.first
        } catch {
            XCTFail("例外が発生しました: \(error.localizedDescription)")
            return nil
        }
    }

}
