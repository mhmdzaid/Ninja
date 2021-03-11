//
//  NinjaRequest.swift
//  Networking Layer
//
//  Created by Mohamed Zead on 3/11/21.
//

import Foundation
/// Custom created NinjaRequestable  , create urs 
enum NinjaRequest: NinjaRequestable , NinjaHandler , NinjaMultipartHandler{
    case country
    case profile([String:Any])
    var path: String{
        switch self{
        case .country:
            return "countries"
        case .profile:
            return "profile"
        }
    }
    
    var mainPath: String{
        return "https://www.servantskw.com/api/"
    }
    
    var method: HttpMethod{
        switch self {
        case .profile:
            return .post
        default:
            return .get
        }
    }
    
    var body: [String : Any]?{
        switch self{

        default:
            return nil
        }
    }
    
    var multipartParams: [String : Any]?{
        switch self{
        case .profile(let params):
            return params
        default :
            return nil
        }
        return nil 
    }
    var headers: [String : String]?{
        return nil
    }
    
    
}

/// The http request method
enum HttpMethod: String {
    case post
    case get
    case delete
    case put
}
