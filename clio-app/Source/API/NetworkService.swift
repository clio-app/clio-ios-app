//
//  NetworkService.swift
//  clio-app
//
//  Created by Thiago Henrique on 21/09/23.
//

import Foundation

final class NetworkService: Network {
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func makeRequest<T: Codable>(for endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.makeURL() else { throw HTTPError.transportError }
    
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = endpoint.headers
        request.httpMethod = endpoint.httpMethod.rawValue
        request.httpBody = endpoint.body
        
        do {
            let (data, _) = try await session.data(for: request)
            return try NetworkingLoader<T>().loadData(data)
        } catch {
            throw HTTPError.transportError
        }
    }
}
