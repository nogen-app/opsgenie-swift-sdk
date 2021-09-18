//
//  File.swift
//  
//
//  Created by Michael Nissen on 18/09/2021.
//

import NIOCore
import Foundation

public class OpsGenieClient {
    /// Default base URL for all OpsGenie resources (defaults to US but can be changed to EU).
    public let baseURL: String

    /// API key for requests requiring authorization.
    public let apiKey: String?

    /// Session Manager to create and perfom requests with.
    public let session: URLSession
 
    public let decoder: JSONDecoder

    public let worker: EventLoopGroup

    // MARK: - Initializer
    
    public init(
        apiKey: String? = nil,
        baseURL: String = NetworkConstants.baseURL.US.rawValue,
        worker: EventLoopGroup
    ) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.worker = worker
        self.session = URLSession(configuration: .default)
        self.decoder = JSONDecoder()
        
        decoder.dateDecodingStrategy = .custom(DateFormatter.customDecoder)
    }
    
    func get<T: Decodable>(_ route: URL?) -> EventLoopFuture<T> {
        guard let route = route else {
            return worker.next().makeFailedFuture(NetworkError.invalidURL)
        }

        return session.jsonBody(
            URLRequest(route, method: .get, headers: ["Authorization": "GenieKey \(self.apiKey ?? "")"]),
            decoder: decoder,
            on: worker.next()).map({ (result: T) in
                return result
            })
    }
}

public extension OpsGenieClient {
    func listAlerts(_ parameters: [String: String]? = nil) -> EventLoopFuture<OpsGenieResponse<[Alert]>> {
        let serializedParameters = parameters?.map({ key, value in
            return "?\(key)=\(value)"
        }).joined(separator: "&")

        let url = "\(self.baseURL)/\(NetworkConstants.clientVersion)/alerts\(serializedParameters ?? "")"

        return self.get(URL(string: url))
    }
    
    func getAlert(id: UUID) -> EventLoopFuture<OpsGenieResponse<Alert>> {
        let url = "\(self.baseURL)/\(NetworkConstants.clientVersion)/alerts/\(id)"
        
        return self.get(URL(string: url))
    }
}
