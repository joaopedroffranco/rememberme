//
//  PasswordCollectionViewCell.swift
//  RememberMe
//
//  Created by Joao Pedro Fabiano Franco on 07/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import UIKit

class PasswordCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var passwordNameLabel: UILabel!
    @IBOutlet weak var passwordContentLabel: UILabel!
    
    func fill(name: String, content: String) {
        self.passwordNameLabel.text = name
        self.passwordContentLabel.text = content
    }
}
