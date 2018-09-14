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
    @IBOutlet weak var passwordDescLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.round()
        self.shadow()
    }
    
    func didSelect() {
        self.passwordContentLabel.textColor = UIColor.white
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
            DispatchQueue.main.async {
                    self.passwordContentLabel.textColor = self.backgroundColor
            }
            timer.invalidate()
        }
    }
    
    func fill(password: Password) {
        self.passwordNameLabel.text = password.name
        self.passwordContentLabel.text = password.content
        self.passwordDescLabel.text = password.desc

        self.backgroundColor = password.category.color
        self.passwordNameLabel.textColor = UIColor.white
        self.passwordContentLabel.textColor = self.backgroundColor
    }
}
