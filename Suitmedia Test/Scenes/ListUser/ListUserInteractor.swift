//
//  ListUserInteractor.swift
//  Suitmedia Test
//
//  Created by Alun Paranggi on 21/10/22.
//

import Foundation
import RxSwift

class ListUserInteractor: ListUserPresenterToInteractorProtocol {
    var presenter: ListUserInteractorToPresenterProtocol?
    let disposeBag = DisposeBag()
    
    func fetchUsers(request: ListUser.ShowUser.Request) {
        UserApiConnector.instance.fetchUsers(page: request.page)
            .do(onNext: { data in
                let response = ListUser.ShowUser.Response(users: data)
                self.presenter?.fetchUsersSuccess(response: response)
            }, onError: { error in
                self.presenter?.fetchUsersFailed(error: error.localizedDescription)
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
}
