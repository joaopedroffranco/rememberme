//
//  PasswordsViewModel.swift
//  RememberMe
//
//  Created by Joao Pedro Fabiano Franco on 08/09/2018.
//  Copyright © 2018 joaopedroffranco. All rights reserved.
//

import UIKit

struct PasswordsSection {
    let category: PasswordCategory
    var passwords: [Password]
    
    init(first: Password) {
        self.category = first.category
        self.passwords = [first]
    }
}

protocol PasswordsViewModelType {
    var parentViewModel: HomeViewModelType! { get set }
    var view: PasswordsViewInterface! { get set }
    var passwords: [Password] { get set }
    var numberOfSections: Int { get }
    func numberOfItems(inSection: Int) -> Int
    func cellForRow(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func update(passwords: [Password])
    func didSelectCell(collectionView: UICollectionView, indexPath: IndexPath)
    func longPressed(collectionView: UICollectionView, gesture: UIGestureRecognizer)
}

class PasswordsViewModel: PasswordsViewModelType {
    var parentViewModel: HomeViewModelType!
    var view: PasswordsViewInterface!
    var passwordsSections: [PasswordsSection] = []
    var passwords: [Password] = [] {
        didSet {
            self.passwordsSections = []
            for password in passwords {
                if let index = passwordsSections.index(where: { (section) -> Bool in return section.category == password.category }) {
                    self.passwordsSections[index].passwords.append(password)
                } else {
                    self.passwordsSections.append(PasswordsSection(first: password))
                }
            }
        }
    }
    
    var numberOfSections: Int {
        get {
            return passwordsSections.count
        }
    }
    
    init(parentViewModel: HomeViewModelType) {
        self.parentViewModel = parentViewModel
    }
    
    func numberOfItems(inSection section: Int) -> Int {
        return self.passwordsSections[section].passwords.count
    }
    
    func cellForRow(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PasswordCollectionViewCell.identifier, for: indexPath) as? PasswordCollectionViewCell else {
            return UICollectionViewCell()
        }

        let password = self.passwordsSections[indexPath.section].passwords[indexPath.row]
        cell.fill(password: password)
        
        return cell
    }
    
    func didSelectCell(collectionView: UICollectionView, indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? PasswordCollectionViewCell {
            cell.didSelect()
        }
    }
    
    func update(passwords: [Password]) {
        self.passwords = passwords
        self.view.reload()
    }
    
    func longPressed(collectionView: UICollectionView, gesture: UIGestureRecognizer) {
        if (gesture.state == .began) {
            let location = gesture.location(in: collectionView)
            if let indexPath = collectionView.indexPathForItem(at: location) {
                let password = self.passwordsSections[indexPath.section].passwords[indexPath.row]
                self.parentViewModel.presentOptionsAlertController(forPassword: password)
            }
        }
    }
}
