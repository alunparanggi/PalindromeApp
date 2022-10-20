//
//  Extensions.swift
//  Suitmedia Test
//
//  Created by Alun Paranggi on 20/10/22.
//

import UIKit

extension String {
    func isPalindrome() -> Bool {
        if count < 2 { return false }
        let str = lowercased().replacingOccurrences(of: " ", with: "")
        let strArray = Array(str)
        var i = 0
        var j = strArray.count-1
        while i <= j {
            if strArray[i] != strArray[j] { return false }
            i+=1
            j-=1
        }
        return true
    }
}

extension UIViewController {
    func navigateTo(_ vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func configureNavigationBar(backgoundColor: UIColor = .white, title: String, titleColor: UIColor = .black) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = backgoundColor
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.isTranslucent = false
        
        let leftLabel = UILabel()
        leftLabel.textColor = titleColor
        leftLabel.text = title
        leftLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftLabel)
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .strongBlue
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        self.navigationItem.leftItemsSupplementBackButton = true
    }
}

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    static let strongBlue: UIColor = UIColor(hex: 0x554AF0)
}
