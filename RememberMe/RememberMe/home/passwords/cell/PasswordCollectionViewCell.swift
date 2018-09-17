//
//  PasswordCollectionViewCell.swift
//  RememberMe
//
//  Created by Joao Pedro Fabiano Franco on 07/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import UIKit

class PasswordCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var passwordBackgroundView: UIView!
    @IBOutlet weak var passwordNameLabel: UILabel!
    @IBOutlet weak var passwordContentLabel: UILabel!
    @IBOutlet weak var passwordDescLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.passwordBackgroundView.round()
        self.shadow()
    }
    
    func didSelect() {
        UIView.animate(withDuration: 0.2, animations: {
            self.passwordBackgroundView.alpha = 0.2
        }) { (completed) in
            if (completed) {
                self.setTimerToDeselect()
            }
        }
    }
    
    func setTimerToDeselect() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2) {
                    self.passwordBackgroundView.alpha = 1
                }
            }
            timer.invalidate()
        }
    }
    
    func fill(password: Password) {
        self.passwordNameLabel.text = password.name
        self.passwordContentLabel.text = password.content
        self.passwordDescLabel.text = password.desc

        self.passwordBackgroundView.backgroundColor = password.category.color
        self.passwordNameLabel.textColor = UIColor.white
        self.passwordContentLabel.textColor = self.passwordBackgroundView.backgroundColor
    }
}
