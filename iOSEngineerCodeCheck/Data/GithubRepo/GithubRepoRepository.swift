//
//  GithubRepoRepository.swift
//  iOSEngineerCodeCheck
//
//  Created by 大内麻衣子 on 2022/11/06.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

class GithubRepoRepository {

    static let queryFormat: String = "q=%@&page=%d&per_page=100"
    static let resource: String = "search/repositories"

    let apiClient: APIClient

    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }

    func getGithubRepositories(for searchWord: String, pageIndex: Int = 0) async throws -> GithubRepo {
        let query = String(format: GithubRepoRepository.queryFormat, searchWord, pageIndex)
        let params = "\(GithubRepoRepository.resource)?\(query)"
        let data = try await apiClient.get(with: params)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        print(String(decoding: data, as: UTF8.self))
        return try decoder.decode(GithubRepo.self, from: data)
    }

}
