//
//  UserCell.swift
//  Suitmedia Test
//
//  Created by Alun Paranggi on 20/10/22.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    static let reusableId = "UserCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        userImage.layer.cornerRadius = 25
    }
    
    func setData(_ data: User) {
        userImage.downloaded(from: data.avatarUrl ?? "")
        userNameLabel.text = "\(data.firstName ?? "") \(data.lastName ?? "")"
        userEmailLabel.text = data.email
    }
    
}
