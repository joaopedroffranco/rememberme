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
    func show(alertController: UIAlertController)
}

class HomeController: UIViewController {
    var emptyView: EmptyView! {
        didSet {
            self.emptyView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    var passwordsView: PasswordsView! {
        didSet {
            self.passwordsView.translatesAutoresizingMaskIntoConstraints = false
            self.passwordsView.viewModel = PasswordsViewModel(parentViewModel: self.homeViewModel)
        }
    }

    var homeViewModel: HomeViewModelType! {
        didSet {
            homeViewModel.controller = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.title = "Minhas senhas"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addPassword))
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .blue
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.homeViewModel.fetchPasswords()
    }
    
    func configureViews() {
        self.emptyView = EmptyView.instantiate() as! EmptyView
        self.passwordsView = PasswordsView.instantiate() as! PasswordsView
    }
    
    @objc func addPassword() {
        self.homeViewModel.addPassword()
    }
    
    func showPasswordsView() {
        self.emptyView.removeFromSuperview()

        self.view.addSubview(self.passwordsView)
        NSLayoutConstraint(item: self.passwordsView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.passwordsView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.passwordsView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.passwordsView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        self.view.layoutIfNeeded()
    }
    
    func showEmptyView() {
        self.passwordsView.removeFromSuperview()
        
        self.view.addSubview(self.emptyView)
        NSLayoutConstraint(item: self.emptyView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.emptyView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.emptyView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: self.emptyView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        self.view.layoutIfNeeded()
    }
}

extension HomeController: HomeControllerInterface {
    func show(state: HomeControllerState, withPasswords: [Password]) {
        switch state {
        case .empty:
            self.showEmptyView()
        case .passwords:
            self.showPasswordsView()
            self.passwordsView.viewModel.update(passwords: withPasswords)
        default:
            self.showEmptyView()
        }
    }
    
    func show(alertController: UIAlertController) {
        self.present(alertController, animated: true, completion: nil)
    }
}
