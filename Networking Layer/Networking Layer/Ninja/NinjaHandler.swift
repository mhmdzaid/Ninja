//
//  NinjaHandler.swift
//  Networking Layer
//
//  Created by Mohamed Zead on 3/11/21.
//

import Foundation
/// A type that can send requests to the API
protocol NinjaHandler {
    /// Sends request to the server
    /// - parameter type : Type to parse data to it
    /// - parameter completion : completion handler with result type of the returned object or Ninja error
    func send<T: Codable>(_ type: T.Type, _ completion: @escaping (Result<T, NinjaError>) -> ())
}

///
extension NinjaHandler where Self: NinjaRequestable {
    func send<T: Codable>(_ type: T.Type, _ completion: @escaping (Result<T, NinjaError>) -> ()) {
        guard let request_ = request else { return }
        URLSession.shared.dataTask(with: request_) { data, response, _ in
            if let response_ = response as? HTTPURLResponse {
                NinjaErrorHandler.handle(response_.statusCode,data, completion)
            }
        }.resume()
    }
}
