//
//  APIClientTests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 大内麻衣子 on 2022/11/06.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import XCTest
import Foundation
@testable import iOSEngineerCodeCheck

final class APIClientTests: XCTestCase {

    var apiClient: APIClient?

    override func setUpWithError() throws {
        let config = URLSessionConfiguration.default
        config.protocolClasses = [StubURLProtocol.self]
        let session = URLSession(configuration: config)

        apiClient = APIClient(session: session)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetWithParams() {
        _ = XCTContext.runActivity(named: "成功") { _ in
            Task {
                do {
                    let data = try await apiClient?.get(with: "success")
                    XCTAssertNotNil(data)
                } catch {
                    XCTFail("例外が発生しました: \(error.localizedDescription)")
                }
            }
        }

        _ = XCTContext.runActivity(named: "リダイレクト statusCode: 301") { _ in
            Task {
                do {
                    let data = try await apiClient?.get(with: "301")
                    XCTAssertNotNil(data)
                } catch {
                    XCTFail("例外が発生しました: \(error.localizedDescription)")
                }
            }
        }

        _ = XCTContext.runActivity(named: "リダイレクト statusCode: 302") { _ in
            Task {
                do {
                    let data = try await apiClient?.get(with: "302")
                    XCTAssertNotNil(data)
                } catch {
                    XCTFail("例外が発生しました: \(error.localizedDescription)")
                }
            }
        }

        _ = XCTContext.runActivity(named: "リダイレクト statusCode: 307") { _ in
            Task {
                do {
                    let data = try await apiClient?.get(with: "307")
                    XCTAssertNotNil(data)
                } catch {
                    XCTFail("例外が発生しました: \(error.localizedDescription)")
                }
            }
        }

        _ = XCTContext.runActivity(named: "JOSNフォーマット不正エラー statusCode:400") { _ in
            Task {
                do {
                    _ = try await apiClient?.get(with: "400")
                    XCTFail("例外が発生しませんでした")
                } catch {
                    XCTAssertEqual(error as? APIClientError, APIClientError.invalidJsonError)
                }
            }
        }

        _ = XCTContext.runActivity(named: "URL不明エラー statusCode:404") { _ in
            Task {
                do {
                    _ = try await apiClient?.get(with: "404")
                    XCTFail("例外が発生しませんでした")
                } catch {
                    XCTAssertEqual(error as? APIClientError, APIClientError.urlNotFoundError)
                }
            }
        }

        _ = XCTContext.runActivity(named: "フィールド名不正エラー statusCode:422") { _ in
            Task {
                do {
                    _ = try await apiClient?.get(with: "422")
                    XCTFail("例外が発生しませんでした")
                } catch {
                    XCTAssertEqual(error as? APIClientError, APIClientError.invalidFieldNameError)
                }
            }
        }

        _ = XCTContext.runActivity(named: "サーバーエラー statusCode: 500") { _ in
            Task {
                do {
                    _ = try await apiClient?.get(with: "500")
                    XCTFail("例外が発生しませんでした")
                } catch {
                    XCTAssertEqual(error as? APIClientError, APIClientError.serverError)
                }
            }
        }

        _ = XCTContext.runActivity(named: "不明なエラー statusCode: 1000") { _ in
            Task {
                do {
                    _ = try await apiClient?.get(with: "1000")
                    XCTFail("例外が発生しませんでした")
                } catch {
                    XCTAssertEqual(error as? APIClientError, APIClientError.unknownError)
                }
            }
        }

        _ = XCTContext.runActivity(named: "タイムアウト") { _ in
            Task {
                do {
                    _ = try await apiClient?.get(with: "timeout")
                    XCTFail("例外が発生しませんでした")
                } catch {
                    XCTAssertEqual(error as? APIClientError, APIClientError.unknownError)
                }
            }
        }
    }

    func testPerformanceExample() throws {
        self.measure {
            Task {
                do {
                    let data = try await apiClient?.get(with: "success")
                    XCTAssertNotNil(data)
                } catch {
                    XCTFail("例外が発生しました: \(error.localizedDescription)")
                }
            }
        }
    }

}

class StubURLProtocol: URLProtocol {
    static let statusCodeForUrl: [URL: Int] = [
        URL(string: "\(APIClient.baseUrl)/sucess")!: 200,
        URL(string: "\(APIClient.baseUrl)/301")!: 301,
        URL(string: "\(APIClient.baseUrl)/302")!: 302,
        URL(string: "\(APIClient.baseUrl)/307")!: 307,
        URL(string: "\(APIClient.baseUrl)/400")!: 400,
        URL(string: "\(APIClient.baseUrl)/404")!: 404,
        URL(string: "\(APIClient.baseUrl)/422")!: 422,
        URL(string: "\(APIClient.baseUrl)/500")!: 500,
        URL(string: "\(APIClient.baseUrl)/1000")!: 1000,
        URL(string: "\(APIClient.baseUrl)/timeout")!: 500,
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
            let statusCode = StubURLProtocol.statusCodeForUrl[url]
        {
            // 10秒でタイムアウトするので、10秒以上動作を停止して挙動を確認
            if url == URL(string: "\(APIClient.baseUrl)/timeout") {
                sleep(20)
            }

            // URLごとにテスト用のstatusCodeとdataを取得する
            let statusCode = statusCode

            if let response = HTTPURLResponse(url: url,
                                              statusCode: statusCode,
                                              httpVersion: "HTTP/2",
                                              headerFields: nil) {
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            }

            client?.urlProtocol(self, didLoad: Data())
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {
        // do nothing
    }
    
}
