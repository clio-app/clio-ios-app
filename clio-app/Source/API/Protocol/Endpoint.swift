import Foundation

protocol Endpoint {
    var communicationProtocol: CommunicationProtocol { get }
    var urlBase: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod? { get }
    var body: Data? { get set }
    var headers: [String: String] { get }
    var queries: [URLQueryItem] { get }
}

enum CommunicationProtocol: String {
    case HTTP = "https"
    case WS = "ws"
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

extension Endpoint {
    var httpMethod: HTTPMethod { return .get }

    var headers: [String: String] {
        let defaultHeaders = [
            "Content-Type": "application/json"
        ]
        return defaultHeaders
    }

    var queries: [URLQueryItem] { return [] }
    
    var body: Data? { return nil }
    
    func makeURL() -> URL? {
        guard var component = URLComponents(string: "\(urlBase)\(path)") else { return nil }
        component.scheme = communicationProtocol.rawValue
        component.queryItems = queries.isEmpty ? nil : queries
        return component.url
    }
}
