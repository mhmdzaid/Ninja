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
        guard var updatedRequest = request else { return }
        let data = NSMutableData()
        let boundary = "Boundary-\(UUID().uuidString)"
        let lineBreak = "\r\n"
        updatedRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        body?.forEach({ (key,value) in
            data.append("--\(boundary + lineBreak)".data(using: .utf8)!)
            data.append(("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)").data(using: .utf8)!)
            if value is UIImage{
                let imageData = (value as? UIImage)?.pngData()
                data.append(imageData!)
            }
            
        })
        updatedRequest.httpBody = data as Data
        URLSession.shared.dataTask(with: updatedRequest) { data, response, _ in
            if let response_ = response as? HTTPURLResponse {
                NinjaErrorHandler.handle(response_.statusCode,data, completion)
            }
        }.resume()
    }

   

    
}

extension String{
    func encodedData() -> Data{
        return self.data(using: .utf8)!
    }
}
