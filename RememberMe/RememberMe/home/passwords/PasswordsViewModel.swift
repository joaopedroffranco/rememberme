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
    func cellForRow(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func update(passwords: [Password])
    func didSelectCell(collectionView: UICollectionView, indexPath: IndexPath)
    func longPressed(collectionView: UICollectionView, gesture: UIGestureRecognizer)
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
    
    func cellForRow(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PasswordCollectionViewCell.identifier, for: indexPath) as? PasswordCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let password = self.passwords[indexPath.row]
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
                let password = self.passwords[indexPath.row]
                self.parentViewModel.presentOptionsAlertController(forPassword: password)
            }
        }
    }
}
