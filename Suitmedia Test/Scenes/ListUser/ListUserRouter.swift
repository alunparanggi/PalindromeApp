//
//  ListUserRouter.swift
//  Suitmedia Test
//
//  Created by Alun Paranggi on 21/10/22.
//

import UIKit

class ListUserRouter: ListUserPresenterToRouterProtocol {
    static func createModule(onUserSelectedAction: @escaping ((_ selectedUser: String)-> Void)) -> UIViewController {
        let view = ListUserVC()
        let presenter: ListUserInteractorToPresenterProtocol & ListUserViewToPresenterProtocol = ListUserPresenter()
        let interactor: ListUserPresenterToInteractorProtocol = ListUserInteractor()
        let router: ListUserPresenterToRouterProtocol = ListUserRouter()
        
        view.presenter = presenter
        view.onUserSelectedAction = onUserSelectedAction
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
}
