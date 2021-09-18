//
//  File.swift
//  
//
//  Created by Michael Nissen on 18/09/2021.
//

import Foundation

/// Constants layer related to Network Layer
public struct NetworkConstants {
    
    /// API version
    public static let clientVersion = "v2"

    /// API base URL
    public enum baseURL: String {
        case EU = "https://api.eu.opsgenie.com"
        case US = "https://api.opsgenie.com"
    }
    
    /// A range of status codes that indicate that the resource requested by the SDK
    /// was understood and accepted.
    public static let validStatusCodes: Range<Int> = 200..<300
    
    /// Status code recived when the server could not authenticate the request
    public static let unauthorizedStatusCode: Int = 401

    /// A set of status codes that do not contain response data
    public static let emptyDataStatusCodes: Set<Int> = [204, 205]
}
