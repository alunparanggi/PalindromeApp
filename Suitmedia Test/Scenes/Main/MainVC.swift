//
//  MainVC.swift
//  Suitmedia Test
//
//  Created by Alun Paranggi on 20/10/22.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var palindromeTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    }

}
