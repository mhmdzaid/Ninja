//
//  NinjaMultipartHandler.swift
//  Networking Layer
//
//  Created by Mohamed Zead on 3/11/21.
//

import Foundation
import UIKit

protocol NinjaMultipartHandler {
    func upload<T: Codable>(_ type: T.Type, _ completion: @escaping (Result<T, NinjaError>) -> ())
}

extension NinjaMultipartHandler where Self: NinjaRequestable {
    func upload<T: Codable>(_ type: T.Type, _ completion: @escaping (Result<T, NinjaError>) -> ()) {
        guard var updatedRequest = request else { return } /// new copy to update the request
      //  updatedRequest.httpBody = createBodyWithParameters(parameters: <#T##[String : String]?#>, filePathKey: <#T##String?#>, imageDataKey: <#T##Data#>, boundary: <#T##String#>)
        updatedRequest.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: updatedRequest) { data, response, _ in
            if let response_ = response as? HTTPURLResponse {
                NinjaErrorHandler.handle(response_.statusCode,data, completion)
            }
        }.resume()
    }

    fileprivate func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }

    private
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: Data, boundary: String) -> Data {
        var body = Data();

        if parameters != nil {
            for (key, value) in parameters! {
                body.append("--\(boundary)\r\n".encodedData())
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".encodedData())
                body.append("\(value)\r\n".encodedData())
            }
        }

                let filename = "user-profile.jpg"
                let mimetype = "image/jpg"

                body.append("--\(boundary)\r\n".encodedData())
                body.append("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n".encodedData())
                body.append("Content-Type: \(mimetype)\r\n\r\n".encodedData())
                body.append(imageDataKey)
                body.append("\r\n".encodedData())
                body.append("--\(boundary)--\r\n".encodedData())

        return body
    }
}

extension String{
    func encodedData() -> Data{
        return self.data(using: .utf8)!
    }
}
