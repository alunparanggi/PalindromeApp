//
//  ListUserPresenter.swift
//  Suitmedia Test
//
//  Created by Alun Paranggi on 21/10/22.
//

import Foundation

class ListUserPresenter: ListUserViewToPresenterProtocol {
    var view: ListUserPresenterToViewProtocol?
    var interactor: ListUserPresenterToInteractorProtocol?
    var router: ListUserPresenterToRouterProtocol?
    var users: ListUser.ShowUser.ViewModel?
    
    func fetchUsers(request: ListUser.ShowUser.Request) {
        interactor?.fetchUsers(request: request)
    }
}

extension ListUserPresenter: ListUserInteractorToPresenterProtocol {

    func fetchUsersSuccess(response: ListUser.ShowUser.Response) {
        let mappedData = response.users.map {
            ListUser.ShowUser.ViewModel.DisplayedUser(
                firstName: $0.firstName,
                lastName: $0.lastName,
                email: $0.email,
                avatarUrl: $0.avatarUrl
            )
        }
        
        let viewModel = ListUser.ShowUser.ViewModel(displayedUsers: mappedData)
        users = viewModel
        view?.showUsers()
    }
    
    func fetchUsersFailed(error: String) {
        view?.showError(error: error)
    }
    
}
