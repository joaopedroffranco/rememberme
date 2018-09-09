//
//  PasswordsViewModel.swift
//  RememberMe
//
//  Created by Joao Pedro Fabiano Franco on 08/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import UIKit

protocol PasswordsViewModelType {
    var parentViewModel: HomeViewModelType! { get set }
    var view: PasswordsViewInterface! { get set }
    var passwords: [Password] { get set }
    var sections: Int { get }
    var rows: Int { get }
    func cellForRow(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func update(passwords: [Password])
    func longPressed(tableview: UITableView, gesture: UIGestureRecognizer)
}

class PasswordsViewModel: PasswordsViewModelType {
    var parentViewModel: HomeViewModelType!
    var view: PasswordsViewInterface!
    var passwords: [Password] = []
    
    var sections: Int {
        get {
            return 1
        }
    }
    
    var rows: Int {
        get {
            return passwords.count
        }
    }
    
    init(parentViewModel: HomeViewModelType) {
        self.parentViewModel = parentViewModel
    }
    
    func cellForRow(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PasswordTableViewCell.identifier, for: indexPath) as? PasswordTableViewCell else {
            return UITableViewCell()
        }
        
        let password = self.passwords[indexPath.row]
        cell.fill(name: password.name!, content: password.content!)
        
        return cell
    }
    
    func update(passwords: [Password]) {
        self.passwords = passwords
        self.view.reload()
    }
    
    func longPressed(tableview: UITableView, gesture: UIGestureRecognizer) {
        if (gesture.state == .began) {
            let location = gesture.location(in: tableview)
            if let indexPath = tableview.indexPathForRow(at: location) {
                let password = self.passwords[indexPath.row]
                self.parentViewModel.presentOptionsAlertController(forPassword: password)
            }
        }
    }
}
