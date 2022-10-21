//
//  Enums.swift
//  Suitmedia Test
//
//  Created by Alun Paranggi on 21/10/22.
//

import Foundation

enum CustomError: Error {
    case expected(message: String)
    case unexpected(message: String)
}
