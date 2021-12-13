//
//  UICollectionView+Extensions.swift
//  CellModels
//
//  Created by David Jiménez Guinaldo on 13/12/21.
//

import UIKit

extension UICollectionView {
    func register(_ cellIdentifiers: CollectionCellIdentifier...) {
        for cellIdentifier in cellIdentifiers {
            let nib = UINib(nibName: cellIdentifier.rawValue, bundle: .main)
            register(nib, forCellWithReuseIdentifier: cellIdentifier.rawValue)
        }
    }
}
