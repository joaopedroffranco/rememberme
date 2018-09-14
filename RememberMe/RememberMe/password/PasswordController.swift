//
//  PasswordController.swift
//  RememberMe
//
//  Created by Joao Pedro Fabiano Franco on 09/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import UIKit

protocol PasswordControllerInterface {
    var name: String? { get }
    var content: String? { get }
    var desc: String? { get }
    var category: Int { get }
    func updateView(byPasswordCategory passwordCategory: PasswordCategory)
}

class PasswordController: UIViewController {
    @IBOutlet weak var passwordNameTextField: UITextField!
    @IBOutlet weak var passwordContentTextField: UITextField!
    @IBOutlet weak var passwordDescriptionTextField: UITextField!
    @IBOutlet weak var passwordTypeSegmentedControl: UISegmentedControl! {
        didSet {
            self.passwordTypeSegmentedControl.removeAllSegments()
            self.passwordTypeSegmentedControl.insertSegment(withTitle: PasswordCategory.social.string, at: 0, animated: false)
            self.passwordTypeSegmentedControl.insertSegment(withTitle: PasswordCategory.email.string, at: 1, animated: false)
            self.passwordTypeSegmentedControl.insertSegment(withTitle: PasswordCategory.card.string, at: 2, animated: false)
            self.passwordTypeSegmentedControl.insertSegment(withTitle: PasswordCategory.other.string, at: 3, animated: false)
        }
    }

    var passwordViewModel: PasswordViewModelType! {
        didSet {
            self.passwordViewModel.controller = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let password = self.passwordViewModel.password {
            self.passwordNameTextField.text = password.name
            self.passwordContentTextField.text = password.content
            self.passwordDescriptionTextField.text = password.desc
            self.navigationItem.title = password.name
            self.updateView(byPasswordCategory: password.category)
        } else {
            self.navigationItem.title = "Nova senha"
            self.updateView()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.done))
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    @objc func done() {
        self.passwordViewModel.done()
    }
    
    @IBAction func didChangeSegmentedControlD(_ sender: UISegmentedControl) {
        self.passwordViewModel.didChangeSelectedControl(index: sender.selectedSegmentIndex)
    }
}

extension PasswordController: PasswordControllerInterface {
    var name: String? {
        return self.passwordNameTextField.text ?? nil
    }
    
    var content: String? {
        return self.passwordContentTextField.text ?? nil
    }
    
    var desc: String? {
        return self.passwordDescriptionTextField.text ?? nil
    }
    
    var category: Int {
        return self.passwordTypeSegmentedControl.selectedSegmentIndex
    }
    
    func updateView(byPasswordCategory passwordCategory: PasswordCategory = PasswordCategory.other) {
        UIApplication.shared.statusBarStyle = passwordCategory.statusBarStyle
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : passwordCategory.tintColor]
        self.navigationController?.navigationBar.tintColor = passwordCategory.tintColor
        self.navigationController?.navigationBar.barTintColor = passwordCategory.color
        
        self.passwordTypeSegmentedControl.tintColor = passwordCategory.color
        self.passwordTypeSegmentedControl.selectedSegmentIndex = passwordCategory.rawValue
    }
}
