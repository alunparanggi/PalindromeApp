//
//  ListUserModel.swift
//  Suitmedia Test
//
//  Created by Alun Paranggi on 21/10/22.
//

import Foundation

enum ListUser {
    enum ShowUser {
        struct Request{
            let page: Int
        }
        
        struct Response{
            let users: [User]
        }
        
        struct ViewModel {
            struct DisplayedUser {
                let firstName: String?
                let lastName: String?
                let email: String?
                let avatarUrl: String?
            }
            
            let displayedUsers: [DisplayedUser]
        }
    }
}
