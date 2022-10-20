//
//  MainVC.swift
//  Suitmedia Test
//
//  Created by Alun Paranggi on 20/10/22.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var palindromeTF: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func showLogoutAlert(isPalindrome: Bool?) {
        guard let isPalindrome = isPalindrome else { return }
        let alert = UIAlertController(title: isPalindrome ? "isPalindrome" : "not palindrome", message: nil, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onCheckBtnPressed() {
        showLogoutAlert(isPalindrome: palindromeTF.text?.isPalindrome())
    }
    
    @IBAction func onNextBtnPressed() {
        let vc = WelcomeVC(name: nameTF.text)
        navigateTo(vc)
    }

}
