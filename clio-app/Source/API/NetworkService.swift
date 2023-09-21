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
    
    func makeRequest<T: Decodable>(for endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.makeURL() else { throw HTTPError.transportError }
    
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = endpoint.headers
        request.httpBody = endpoint.body
        request.httpMethod = endpoint.httpMethod?.rawValue
        
        do {
            let (data, response) = try await session.data(for: request)
            let httpResponse = response as! HTTPURLResponse
            let status = httpResponse.statusCode
            guard (200...299).contains(status) else { throw HTTPError.serverSideError(status) }
            return try NetworkingLoader<T>().loadData(data)
        } catch {
            throw error
        }
    }
}
