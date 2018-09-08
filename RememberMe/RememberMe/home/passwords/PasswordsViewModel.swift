//
//  PasswordsViewModel.swift
//  RememberMe
//
//  Created by Joao Pedro Fabiano Franco on 08/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import UIKit

protocol PasswordsViewModelType {
    var view: PasswordsViewInterface! { get set }
    var passwords: [Password] { get set }
    var sections: Int { get }
    var rows: Int { get }
    func cellForRow(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell
    func update(passwords: [Password])
}

class PasswordsViewModel: PasswordsViewModelType {
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
}
