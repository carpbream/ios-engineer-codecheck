//
//  Bundle+.swift
//  iOSEngineerCodeCheck
//
//  Created by 大内麻衣子 on 2022/11/09.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

extension Bundle {

    func data(for jsonResourceName: String) -> Data? {
        guard let url = self.url(forResource: jsonResourceName, withExtension: "json") else {
            print("ファイルが見つかりません: \(jsonResourceName)")
            return nil
        }

        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            print("対象のファイルからデータを作成できませんでした: \(jsonResourceName)")
            return nil
        }
    }

    func object<T: Decodable>(for jsonResourceName: String) throws -> T {
        guard let url = self.url(forResource: jsonResourceName, withExtension: "json") else {
            throw URLError(.fileDoesNotExist)
        }

        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(T.self, from: data)
    }

}
