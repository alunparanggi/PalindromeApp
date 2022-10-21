//
//  User.swift
//  Suitmedia Test
//
//  Created by Alun Paranggi on 21/10/22.
//

import Foundation
import SwiftyJSON

struct User {
    var firstName: String?
    var lastName: String?
    var email: String?
    var avatarUrl: String?
    
    static func with(json: JSON) -> User {
        var item = User()
        
        if json["email"].exists() {
            item.email = json["email"].string
        }
        if json["first_name"].exists() {
            item.firstName = json["first_name"].string
        }
        if json["last_name"].exists() {
            item.lastName = json["last_name"].string
        }
        if json["avatar"].exists() {
            item.avatarUrl = json["avatar"].string
        }
        
        return item
    }
}
