//
//  Loader.swift
//  clio-app
//
//  Created by Thiago Henrique on 21/09/23.
//

import Foundation

struct NetworkingLoader<T: Decodable> {
    func loadData(_ data: Data) throws -> T {
        do {
            let decodedJson = try JSONDecoder().decode(T.self, from: data)
            return decodedJson
        } catch {
            throw MapperError.decodingError
        }
    }
}

