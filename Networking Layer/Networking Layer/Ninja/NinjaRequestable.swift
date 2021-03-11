//
//  NinjaRequestable.swift
//  Networking Layer
//
//  Created by Mohamed Zead on 3/11/21.
//

import Foundation

/// Protocol for specifying request properties 
protocol NinjaRequestable {
    /// Endpoint of the URL
    var path: String { get }
    /// The base of the URL i.e. the main body of the link
    var mainPath: String { get }
    /// Request to be filled with request properties such as parameters , headers , etc..
    var request: URLRequest? { get }
    /// Mehtod of the api request
    var method: HttpMethod { get }
    /// Body to be sent in the request
    var body: [String: Any]? { get }
    /// Body for multipart request
    var multipartParams : [String:Any]?{get}
    /// Request Headers such as lang , authorization , .. etc
    var headers: [String: String]? { get }
}

extension NinjaRequestable {
    var request: URLRequest? {
        let urlString = (mainPath + path).addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? ""
        guard let url = URL(string: urlString) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if let body_ = body , multipartParams == nil {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body_, options: [])
            } catch {
                print(error.localizedDescription)
            }
        }
        return request
    }
}
