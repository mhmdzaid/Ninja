//
//  NinjaErrorHandler.swift
//  Networking Layer
//
//  Created by Mohamed Zead on 3/11/21.
//

import Foundation

final class NinjaErrorHandler{
    static func handle<T:Codable>(_ code : Int,_ data : Data?,_ completion : @escaping(Result<T,NinjaError>)->()){
        print("-----------\(code)-------")
        switch code {
        case 200...299: /// prase data returned
            if let data_ = data {
                let parser = NinjaParser<T>(data_)
                let parsedContent = parser.parse()
                completion(.success(parsedContent))
            }
        case 400:
            completion(.failure(.badRequest))
        case 404:
            completion(.failure(.notFound))
        case 405:
            completion(.failure(.methodNotAllowed))
        case 500:
            completion(.failure(.internalServerError))
        default:
            completion(.failure(.message("Something went wrong")))
        }
    }
}
