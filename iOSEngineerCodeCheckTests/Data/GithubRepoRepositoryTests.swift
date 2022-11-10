//
//  GithubRepoRepositoryTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 大内麻衣子 on 2022/11/09.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

final class GithubRepoRepositoryTests: XCTestCase {

    var session: URLSession?
    var apiClient: APIClient?
    var repository: GithubRepoRepository?

    override func setUpWithError() throws {
        // sessionのスタブを作成
        let config = URLSessionConfiguration.default
        config.protocolClasses = [GithubRepositoryURLProtocol.self]
        let session = URLSession(configuration: config)

        // テスト用APIClientを作成
        apiClient = APIClient(session: session)

        // テスト用repositoryを作成
        repository = GithubRepoRepository(apiClient: apiClient!)
    }

    override func tearDownWithError() throws {}

    // TODO: 各カラムのバリューの値が想定されている内容かチェックする
    // TODO: Dateのフォーマットが誤っている場合のバリエーション
    // TODO: DecodingErrorの具体的なエラーとの比較
    func testGetGithubRepository() throws {
        _ = XCTContext.runActivity(named: "成功_パース可能な最小限のデータ(itemsが空のリスト)") { _ in
            Task {
                do {
                    let data = try await repository?.getGithubRepositories(for: "github_repo_minimum_no_item", pageIndex: 0)
                    XCTAssertNotNil(data)
                } catch {
                    XCTFail("例外が発生しました: \(error.localizedDescription)")
                }
            }
        }

        _ = XCTContext.runActivity(named: "成功_パース可能な最小限のデータ(itemsに1件データ有り)") { _ in
            Task {
                do {
                    let data = try await repository?.getGithubRepositories(for: "github_repo_minimum", pageIndex: 0)
                    XCTAssertNotNil(data)
                } catch {
                    XCTFail("例外が発生しました: \(error.localizedDescription)")
                }
            }
        }

        _ = XCTContext.runActivity(named: "成功_パース可能な最大限のデータ") { _ in
            Task {
                do {
                    let data = try await repository?.getGithubRepositories(for: "github_repo_maximum", pageIndex: 0)
                    XCTAssertNotNil(data)
                } catch {
                    XCTFail("例外が発生しました: \(error.localizedDescription)")
                }
            }
        }

        _ = XCTContext.runActivity(named: "失敗_データが空") { _ in
            Task {
                do {
                    _ = try await repository?.getGithubRepositories(for: "github_repo_empty", pageIndex: 0)
                    XCTFail("例外が発生しませんでした")
                } catch {
                    XCTAssertTrue(error is DecodingError)
                }
            }
        }

        _ = XCTContext.runActivity(named: "失敗_パースエラー") { _ in
            Task {
                do {
                    _ = try await repository?.getGithubRepositories(for: "github_repo_parse_error", pageIndex: 0)
                    XCTFail("例外が発生しませんでした")
                } catch {
                    XCTAssertTrue(error is DecodingError)
                }
            }
        }
    }

    func testPerformanceExample() throws {
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

class GithubRepositoryURLProtocol: URLProtocol {
    // クエリ文字列をもとにテストデータファイルのリソース名を取得する
    static let resourceForQuery: [String: String] = [
        String(format: GithubRepoRepository.queryFormat, "github_repo_minimum"):
            "github_repo_minimum",

        String(format: GithubRepoRepository.queryFormat, "github_repo_minimum_no_item"):
            "github_repo_minimum_no_item",

        String(format: GithubRepoRepository.queryFormat, "github_repo_maximum"):
            "github_repo_maximum",

        String(format: GithubRepoRepository.queryFormat, "github_repo_empty"):
            "github_repo_empty",

        String(format: GithubRepoRepository.queryFormat, "github_repo_parse_error"):
            "github_repo_parse_error",
    ]

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {

        if
            let url = request.url,
            let urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: true),
            let resource = GithubRepositoryURLProtocol.resourceForQuery[urlComponent.query ?? ""]
        {
            // ネットワーク層のエラーはAPIClientTestで行うので、URLResponseは常に成功ステータス
            if let response = HTTPURLResponse(url: url,
                                              statusCode: 200,
                                              httpVersion: "HTTP/2",
                                              headerFields: nil) {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }

            let bundle = Bundle(for: type(of: self))
            let data = bundle.data(for: resource)
            client?.urlProtocol(self, didLoad: data!)
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {
        // do nothing
    }

}
