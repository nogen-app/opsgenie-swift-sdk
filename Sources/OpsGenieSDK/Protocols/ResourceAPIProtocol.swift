//
//  File.swift
//  
//
//  Created by Michael Nissen on 18/09/2021.
//

import Foundation

public enum Resource: String {
    case alerts = "alerts"
    case incidents = "incidents"
}

public enum HTTPMethod: String {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case options = "OPTIONS"
    case trace = "TRACE"
}

public enum RequestParameters {
    case body(_ : [String: Any])
    case get(_ : [String: String])
}

public protocol ResourceAPIProtocol {
    var path: String { get }
    
    var method: HTTPMethod { get }
    
    var parameters: RequestParameters { get }
}

