//
//  ListUser.swift
//  Suitmedia Test
//
//  Created by Alun Paranggi on 20/10/22.
//

import UIKit

class ListUserVC: UIViewController {

    @IBOutlet weak var userTableView: UITableView!
    
    var presenter: ListUserViewToPresenterProtocol?
    var onUserSelectedAction: ((_ selectedUser: String)-> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureRefreshControl()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareUI()
    }
    
    private func configureRefreshControl() {
        userTableView.refreshControl = UIRefreshControl()
        userTableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc func handleRefreshControl() {
        fetchData()
        DispatchQueue.main.async { [weak self] in
            self?.userTableView.refreshControl?.endRefreshing()
        }
    }
    private func prepareUI() {
        configureNavigationBar(title: "Third Screen")
        initTableView(tableView: userTableView, nibName: UserCell.reusableId)
    }
    
    private func fetchData() {
        let req = ListUser.ShowUser.Request(page: 1)
        presenter?.fetchUsers(request: req)
    }
    
    private func initTableView(tableView: UITableView, nibName: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: nibName)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = false
    }
}

extension ListUserVC: ListUserPresenterToViewProtocol {
    func showUsers() {
        userTableView.reloadData()
    }
    
    func showError(error: String) {
        print(error)
    }
}


extension ListUserVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.users?.displayedUsers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reusableId, for: indexPath) as! UserCell
        if let user = presenter?.users?.displayedUsers[indexPath.row] {
            let data = User(firstName: user.firstName, lastName: user.lastName, email: user.email, avatarUrl: user.avatarUrl)
            cell.setData(data)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let user = presenter?.users?.displayedUsers[indexPath.row] {
            let firstName = user.firstName ?? ""
            let lastName = user.lastName ?? ""
            onUserSelectedAction?("\(firstName) \(lastName)")
        }
        popViewController()
    }
}
