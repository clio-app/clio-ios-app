//
//  Network.swift
//  clio-app
//
//  Created by Thiago Henrique on 21/09/23.
//

import Foundation

protocol Network {
    func makeRequest<T: Codable>(for endpoint: Endpoint) async throws -> T
}
