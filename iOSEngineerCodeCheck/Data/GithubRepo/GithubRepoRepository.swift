//
//  GithubRepoRepository.swift
//  iOSEngineerCodeCheck
//
//  Created by 大内麻衣子 on 2022/11/06.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

class GithubRepoRepository {
    func getGithubRepositories(for searchWord: String) async throws -> GithubRepo {
        let urlString = "https://api.github.com/search/repositories?q=\(searchWord)"
        let apiClient = APIClient()
        let data = try await apiClient.request(with: urlString)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(GithubRepo.self, from: data)
    }
}
