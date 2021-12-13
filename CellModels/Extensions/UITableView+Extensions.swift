//
//  UITableView+Extensions.swift
//  CellModels
//
//  Created by David Jiménez Guinaldo on 12/12/21.
//

import UIKit

extension UITableView {
    func register(_ cellIdentifiers: CellIdentifier...) {
        for cellIdentifier in cellIdentifiers {
            let nib = UINib(nibName: cellIdentifier.rawValue, bundle: .main)
            register(nib, forCellReuseIdentifier: cellIdentifier.rawValue)
        }
    }
}
