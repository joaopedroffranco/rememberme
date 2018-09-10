//
//  PasswordController.swift
//  RememberMe
//
//  Created by Joao Pedro Fabiano Franco on 09/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import UIKit

protocol PasswordControllerInterface {
    func getPasswordInfo() -> (name: String?, content: String?)
}

class PasswordController: UIViewController {
    @IBOutlet weak var passwordNameTextField: UITextField!
    @IBOutlet weak var passwordContentTextField: UITextField!

    var passwordViewModel: PasswordViewModelType! {
        didSet {
            self.passwordViewModel.controller = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.passwordNameTextField.text = self.passwordViewModel.password?.name ?? nil
        self.passwordContentTextField.text = self.passwordViewModel.password?.content ?? nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = self.passwordViewModel.password?.name ?? "Nova senha"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.done))
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .blue
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    @objc func done() {
        self.passwordViewModel.done()
    }
}

extension PasswordController: PasswordControllerInterface {
    func getPasswordInfo() -> (name: String?, content: String?) {
        return (name: self.passwordNameTextField.text, content: self.passwordContentTextField.text)
    }
}
