//
//  APIClient.swift
//  iOSEngineerCodeCheck
//
//  Created by 大内麻衣子 on 2022/11/06.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

class APIClient {
    func request(with urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw APIClientError.invalidURLError
        }

        let (data, urlResponse) = try await URLSession.shared.data(from: url)
        guard let urlResponse = urlResponse as? HTTPURLResponse else {
            throw APIClientError.responseError
        }

        // statusCodeが200~300番台以外はエラーをthrow
        if urlResponse.statusCode < 200 {
            throw APIClientError.unknownError
        } else if 400 <= urlResponse.statusCode {
            throw APIClientError.clientError
        } else if 500 <= urlResponse.statusCode {
            throw APIClientError.serverError
        } else if 600 <= urlResponse.statusCode {
            throw APIClientError.unknownError
        }

        return data
    }
}

enum APIClientError: Error, LocalizedError {
    case invalidURLError
    case responseError
    case clientError
    case serverError
    case unknownError

    var errorDescription: String? {
        switch self {
        case .invalidURLError: return "URLが不正です"
        case .responseError: return "HTTPレスポンスが不正です"
        case .clientError: return "クライアントエラーです"
        case .serverError: return "サーバーエラーです"
        case .unknownError: return "不明なエラーです"
        }
    }
}
