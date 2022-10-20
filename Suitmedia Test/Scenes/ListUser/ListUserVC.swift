//
//  ListUser.swift
//  Suitmedia Test
//
//  Created by Alun Paranggi on 20/10/22.
//

import UIKit

class ListUserVC: UIViewController {

    @IBOutlet weak var userTableView: UITableView!
    
    var onUserSelectedAction: ((_ selectedUser: String)-> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareUI()
    }

    private func prepareUI() {
        configureNavigationBar(title: "Third Screen")
        initTableView(tableView: userTableView, nibName: UserCell.reusableId)
    }
    
    private func initTableView(tableView: UITableView, nibName: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: nibName)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsMultipleSelection = false
    }

}

extension ListUserVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.reusableId, for: indexPath) as! UserCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onUserSelectedAction?("\(indexPath.row)")
        popViewController()
    }
}