//
//  File.swift
//  
//
//  Created by Michael Nissen on 18/09/2021.
//

import Foundation

public struct AlertIntegration: Codable {
    let id: UUID
    let name: String
    let type: String
}

public struct AlertReport: Codable {
    let ackTime: Int
    let closeTime: Int
    let acknowledgedBy: String?
    let closedBy: String?
}

public struct Alert: Codable {
//    let id: UUID
    let id: String
    let message: String
//    let status: Status
    let acknowledged: Bool
    let isSeen: Bool
    let tags: [String]
    let snoozed: Bool
    let snoozedUntil: Date?
    let count: Int
    let lastOccurredAt: Date
    let createdAt: Date
    let updatedAt: Date
    let source: String
    let owner: String?
//    let priority: Priority
//    let responders: [Responder]
//    let integration: AlertIntegration
//    let report: AlertReport
    let actions: [String]?
    let entity: String?
    let description: String?
}
