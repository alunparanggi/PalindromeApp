//
//  UserApiConnector.swift
//  Suitmedia Test
//
//  Created by Alun Paranggi on 21/10/22.
//

import Foundation
import RxSwift
import Alamofire

class UserApiConnector: ApiConnector {
    static let instance = UserApiConnector()
    
    private let ENDPOINT_USER = "/api/users"
    
    func fetchUsers(page: Int) -> Observable<[User]> {
        var result = [User]()
        let parameters: [String : Any] = [
            "page": page,
        ]
        
        let request = manager.request(ENDPOINT_USER, method: .get, parameters: parameters)
        return request.rx_JSON().mapJSONResponse().map{ response in
            if response.result.exists() {
                for data in response.result["data"].arrayValue {
                    result.append(User.with(json: data))
                }
            }
            return result
        }
    }
}
