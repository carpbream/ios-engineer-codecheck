//
//  APIClient.swift
//  iOSEngineerCodeCheck
//
//  Created by 大内麻衣子 on 2022/11/06.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

class APIClient {

    static let baseUrl: String = "https://api.github.com"
    static let timeout: Double = 10.0 // githubのタイムアウト設定と同じ
    let session: URLSession

    init(session: URLSession = URLSession.shared) {
        self.session = session
    }

    func get(with params: String) async throws -> Data {
        let url = URL(string: "\(APIClient.baseUrl)/\(params)")!

        let request = URLRequest(url: url, timeoutInterval: APIClient.timeout)
        let (data, urlResponse) = try await session.data(for: request)
        guard let urlResponse = urlResponse as? HTTPURLResponse else {
            throw APIClientError.noResponseError
        }

        if urlResponse.statusCode < 200 {
            throw APIClientError.unknownError
        } else if urlResponse.statusCode == 400 {
            throw APIClientError.invalidJsonError
        } else if urlResponse.statusCode == 404 {
            throw APIClientError.urlNotFoundError
        } else if urlResponse.statusCode == 422 {
            throw APIClientError.invalidFieldNameError
        } else if 400 < urlResponse.statusCode, urlResponse.statusCode < 500 {
            throw APIClientError.clientError
        } else if 500 <= urlResponse.statusCode, urlResponse.statusCode < 600 {
            throw APIClientError.serverError
        } else if 600 <= urlResponse.statusCode {
            throw APIClientError.unknownError
        }

        return data
    }

}

enum APIClientError: Error, LocalizedError {
    
    case noResponseError
    case invalidJsonError
    case urlNotFoundError
    case invalidFieldNameError
    case clientError
    case serverError
    case unknownError

    var errorDescription: String? {
        switch self {
        case .noResponseError: return "Responseが存在しません"
        case .invalidJsonError: return "JSONフォーマットが不正です"
        case .urlNotFoundError: return "URLが存在しません"
        case .invalidFieldNameError: return "フィールド名が不正です"
        case .clientError: return "クライアントエラーです"
        case .serverError: return "サーバーエラーです"
        case .unknownError: return "不明なエラーです"
        }
    }

}
