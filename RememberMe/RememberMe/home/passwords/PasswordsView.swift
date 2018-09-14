//
//  PasswordsView.swft
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
    @IBOutlet weak var passwordsCollectionView: UICollectionView! {
        didSet {
            let cellNib = UINib(nibName: "PasswordCollectionViewCell", bundle: nil)
            self.passwordsCollectionView.register(cellNib, forCellWithReuseIdentifier: PasswordCollectionViewCell.identifier)
            self.passwordsCollectionView.dataSource = self
            self.passwordsCollectionView.delegate = self
        }
    }
    
    var viewModel: PasswordsViewModelType! {
        didSet {
            self.viewModel.view = self
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressed))
        self.passwordsCollectionView.addGestureRecognizer(longPressGesture)
    }
    
    @objc func longPressed(gesture: UILongPressGestureRecognizer) {
        self.viewModel.longPressed(collectionView: self.passwordsCollectionView, gesture: gesture)
    }
}

extension PasswordsView: PasswordsViewInterface {
    func reload() {
        self.passwordsCollectionView.reloadData()
    }
}

extension PasswordsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.viewModel.sections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.items(forSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.viewModel.cellForRow(collectionView: collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.didSelectCell(collectionView: collectionView, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.bounds.width - 12.0, height: 90.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 3.0, bottom: 3.0, right: 3.0)
    }
}
