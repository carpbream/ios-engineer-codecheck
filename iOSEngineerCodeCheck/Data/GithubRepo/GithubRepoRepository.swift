//
//  GithubRepoRepository.swift
//  iOSEngineerCodeCheck
//
//  Created by 大内麻衣子 on 2022/11/06.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

class GithubRepoRepository {

    let apiClient: APIClient

    init(apiClient: APIClient = APIClient()) {
        self.apiClient = apiClient
    }

    func getGithubRepositories(for searchWord: String, pageIndex: Int = 0) async throws -> GithubRepo {
        let params = "/search/repositories?q=\(searchWord)&page=\(pageIndex)&per_page=100"
        let data = try await apiClient.get(with: params)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(GithubRepo.self, from: data)
    }
}
