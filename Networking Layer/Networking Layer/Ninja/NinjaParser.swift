//
//  NinjaParser.swift
//  Networking Layer
//
//  Created by Mohamed Zead on 3/11/21.
//

import Foundation

/// Responsible for parsing given data
final class NinjaParser<T : Codable>{
    
    private var data : Data!
    init(_ data : Data) {
        self.data = data
    }
    /// parses returned data from the API into codable struct
    /// - returns: Generic decoded object
    func parse() -> T{
        do {
            return try JSONDecoder().decode(T.self, from: data)
        }catch let error{
            fatalError(error.localizedDescription)
        }
    }
}
