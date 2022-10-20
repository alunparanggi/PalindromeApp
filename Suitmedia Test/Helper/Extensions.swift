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
