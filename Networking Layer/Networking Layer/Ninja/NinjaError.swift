//
//  NinjaError.swift
//  Networking Layer
//
//  Created by Mohamed Zead on 3/11/21.
//

import Foundation
///Custom Error to indicate each status code 
enum NinjaError : Swift.Error{
    case message(String)
    case notFound
    case badRequest
    case internalServerError
    case methodNotAllowed
}
