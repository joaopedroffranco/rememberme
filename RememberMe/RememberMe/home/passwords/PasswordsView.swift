//
//  PasswordsTableView.swift
//  RememberMe
//
//  Created by Joao Pedro Fabiano Franco on 07/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import UIKit

protocol PasswordsViewInterface {
    func reload()
}

class PasswordsView: UIView {
    @IBOutlet weak var passwordsTableView: UITableView! {
        didSet {
            let cellNib = UINib(nibName: "PasswordTableViewCell", bundle: nil)
            self.passwordsTableView.register(cellNib, forCellReuseIdentifier: PasswordTableViewCell.identifier)
            self.passwordsTableView.dataSource = self
            self.passwordsTableView.delegate = self
        }
    }
    
    var viewModel: PasswordsViewModelType! {
        didSet {
            self.viewModel.view = self
        }
    }
}

extension PasswordsView: PasswordsViewInterface {
    func reload() {
        self.passwordsTableView.reloadData()
    }
}

extension PasswordsView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.viewModel.cellForRow(tableView: tableView, indexPath: indexPath)
    }
}
