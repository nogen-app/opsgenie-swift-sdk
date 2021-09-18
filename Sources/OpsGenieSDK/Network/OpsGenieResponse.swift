//
//  File.swift
//  
//
//  Created by Michael Nissen on 18/09/2021.
//

import Foundation

public struct Paging: Codable {
    let next: String
    let first: String
    let last: String
}

public struct OpsGenieResponse<T: Codable>: Codable {
    let data: T
    let paging: Paging
    let took: Float
    let requestId: String
//    let requestId: UUID
}
