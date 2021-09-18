//
//  File.swift
//  
//
//  Created by Michael Nissen on 18/09/2021.
//

import Foundation

public enum NetworkError: Error {
    case invalidResponse
    case invalidURL
    case networkError(Error)
}
