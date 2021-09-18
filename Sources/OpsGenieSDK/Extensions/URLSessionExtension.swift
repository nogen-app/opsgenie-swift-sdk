//
//  File.swift
//  
//
//  Created by Michael Nissen on 18/09/2021.
//

import NIOCore
import Foundation

extension URLSession {
    /// Get raw data from given URLRequest
    ///
    /// - parameters:
    ///   - request: URLRequest to execute
    ///   - eventLoop: EventLoop to execute on
    ///
    /// - returns: A future HTTPURLResponse and the Data
    ///
    func data(
      _ request: URLRequest,
      on eventLoop: EventLoop
    ) -> EventLoopFuture<(HTTPURLResponse, Data)> {
      let promise: EventLoopPromise<(HTTPURLResponse, Data)> = eventLoop.makePromise()
      
      let task = self.dataTask(with: request) { data, response, error in
        if let error = error {
          promise.fail(NetworkError.networkError(error))
          return
        }
        
        guard let response = response as? HTTPURLResponse else {
          promise.fail(NetworkError.invalidResponse)
          return
        }
        promise.succeed((response, data ?? Data()))
      }
      
      task.resume()
      return promise.futureResult
    }
    
    /// Get a decodable from given URLRequest
    ///
    /// - parameters:
    ///   - request: URLRequest to execute
    ///   - type: Type to decode to
    ///   - decoder: Decoder to decode data with
    ///   - eventLoop: EventLoop to execute on
    ///
    /// - returns: A future HTTPURLResponse and the Decoded object
    ///
    func json<T: Decodable>(
        _ request: URLRequest,
        type: T.Type = T.self,
        decoder: JSONDecoder = JSONDecoder(),
        on eventLoop: EventLoop
    ) -> EventLoopFuture<(HTTPURLResponse, T)> {
        return data(request, on: eventLoop).flatMapThrowing {
            return ($0.0, try decoder.decode(type, from: $0.1))
        }
    }
    
    /// Get a decodable from given URLRequest
    ///
    /// - parameters:
    ///   - request: URLRequest to execute
    ///   - type: Type to decode to
    ///   - decoder: Decoder to decode data with
    ///   - eventLoop: EventLoop to execute on
    ///
    /// - returns: A future Decoded object
    ///
    func jsonBody<T: Decodable>(
        _ request: URLRequest,
        type: T.Type = T.self,
        decoder: JSONDecoder = JSONDecoder(),
        on eventLoop: EventLoop
    ) -> EventLoopFuture<T> {
        return json(request, type: type, decoder: decoder, on: eventLoop).map {
            return $0.1
        }
    }
}
