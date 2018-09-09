//
//  HomeController.swift
//  RememberMe
//
//  Created by Joao Pedro Fabiano Franco on 07/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import UIKit

enum HomeControllerState {
    case empty
    case passwords
    case error
}

protocol HomeControllerInterface {
    func show(state: HomeControllerState, withPasswords: [Password])
}

class HomeController: UIViewController {
    var emptyView: EmptyView! {
        didSet {
            self.view.addSubview(self.emptyView)
            self.emptyView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
            self.emptyView.heightAnchor.constraint(equalToConstant: self.view.frame.height).isActive = true
            self.emptyView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
            self.emptyView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
            self.emptyView.isHidden = false
        }
    }

    var passwordsView: PasswordsView! {
        didSet {
            self.view.addSubview(self.passwordsView)
            self.passwordsView.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
            self.passwordsView.heightAnchor.constraint(equalToConstant: self.view.frame.height).isActive = true
            self.passwordsView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor).isActive = true
            self.passwordsView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor).isActive = true
            self.passwordsView.isHidden = true

            self.passwordsView.viewModel = PasswordsViewModel()
        }
    }

    var homeViewModel: HomeViewModelType! {
        didSet {
            homeViewModel.controller = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.translatesAutoresizingMaskIntoConstraints = false

        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = "Minhas senhas"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addPassword))
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .blue
        self.navigationController?.navigationBar.tintColor = .white
        
        self.configureViews()
        
        self.homeViewModel.fetchPasswords()
    }
    
    func configureViews() {
        self.emptyView = EmptyView.instantiate() as! EmptyView
        self.passwordsView = PasswordsView.instantiate() as! PasswordsView
        self.view.layoutIfNeeded()
    }
    
    @objc func addPassword() {
        self.homeViewModel.addPassword()
    }
}

extension HomeController: HomeControllerInterface {
    func show(state: HomeControllerState, withPasswords: [Password]) {
        self.emptyView.isHidden = !(state == .empty) && !(state == .error)
        self.passwordsView.isHidden = !(state == .passwords)
        
        self.passwordsView.viewModel.update(passwords: withPasswords)
    }
}
