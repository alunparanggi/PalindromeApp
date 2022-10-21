//
//  WelcomeVC.swift
//  Suitmedia Test
//
//  Created by Alun Paranggi on 20/10/22.
//

import UIKit

class WelcomeVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var selectedUserLabel: UILabel!
    
    private var name: String?
    
    init(name: String?) {
        super.init(nibName: nil, bundle: nil)
        self.name = name
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareUI()
    }
    
    private func prepareUI() {
        configureNavigationBar(title: "Second Screen")
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        nameLabel.text = name
    }
    
    private func updateSelectedUser(_ name: String) {
        selectedUserLabel.text = name
    }
    
    @IBAction func onChooseUserBtnPressed() {
        let vc = ListUserRouter.createModule(onUserSelectedAction: updateSelectedUser)
        navigateTo(vc)
    }
}
