//
//  File.swift
//  
//
//  Created by Michael Nissen on 18/09/2021.
//

import Foundation

extension URLRequest {
  /// Create a new URLRequest with a body
  init<T: Encodable>(
    url: URL,
    method: HTTPMethod = .post,
    headers: [String: String] = [:],
    json body: T,
    encoder: JSONEncoder = JSONEncoder()) throws
  {
    self.init(url: url)
    
    setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    headers.forEach { header, value in
      setValue(value, forHTTPHeaderField: header)
    }
    
    httpMethod = method.rawValue
    httpBody = try encoder.encode(body)
  }
  
  /// Create a new URLRequest with URL and Method
  init(_ url: URL, method: HTTPMethod = .get, headers: [String: String] = [:]) {
    self.init(url: url)
    
    headers.forEach { (header, value) in
      setValue(value, forHTTPHeaderField: header)
    }
    
    httpMethod = method.rawValue
  }
}

