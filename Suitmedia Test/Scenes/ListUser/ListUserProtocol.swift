//
//  ListUserProtocol.swift
//  Suitmedia Test
//
//  Created by Alun Paranggi on 21/10/22.
//

import UIKit

protocol ListUserPresenterToInteractorProtocol: AnyObject {
    var presenter: ListUserInteractorToPresenterProtocol? { get set }
    
    func fetchUsers(request: ListUser.ShowUser.Request)
}

protocol ListUserInteractorToPresenterProtocol: AnyObject {
    func fetchUsersSuccess(response: ListUser.ShowUser.Response)
    func fetchUsersFailed(error: String)
}

protocol ListUserPresenterToViewProtocol: AnyObject {
    func showUsers()
    func showError(error: String)
}

protocol ListUserViewToPresenterProtocol: AnyObject {
    var view: ListUserPresenterToViewProtocol? { get set }
    var interactor: ListUserPresenterToInteractorProtocol? { get set }
    var router: ListUserPresenterToRouterProtocol? { get set }
    var users: ListUser.ShowUser.ViewModel? { get }
    
    func fetchUsers(request: ListUser.ShowUser.Request)
}

protocol ListUserPresenterToRouterProtocol: AnyObject {
    static func createModule(onUserSelectedAction: @escaping ((_ selectedUser: String)-> Void)) -> UIViewController
}
