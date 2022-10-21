//
//  ApiConnector.swift
//  Suitmedia Test
//
//  Created by Alun Paranggi on 21/10/22.
//

import Foundation
import Alamofire
import RxSwift
import SwiftyJSON

let BASE_URL = Bundle.main.infoDictionary?["BASE_URL"] as? String ?? ""

struct APIResponse {
    var code: Int
    var message: String
    var result: JSON
}

class ApiConnector: NSObject {
    let manager: ApiManager
    
    override init() {
        let configuration = URLSessionConfiguration.af.default
        configuration.headers = HTTPHeaders.default
        configuration.timeoutIntervalForRequest = 60*8
        manager = ApiManager.init(configuration: configuration)
        super.init()
    }
}

class ApiManager: Session  {
    internal override func request(_ convertible: URLConvertible, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders? = nil, interceptor: RequestInterceptor? = nil, requestModifier: Session.RequestModifier? = nil) -> DataRequest {
        var overridedParameters = [String : AnyObject]()
        
        if let parameters = parameters {
            overridedParameters = parameters as [String : AnyObject]
        }
        
        return super.request(BASE_URL+"\(convertible)", method: method, parameters: overridedParameters, encoding: encoding, interceptor: interceptor, requestModifier: requestModifier).customValidation().cURLDescription{ curl in print(curl) }
    }
}
