//
//  UIViewController+Extensions.swift
//  CellModels
//
//  Created by David Jiménez Guinaldo on 12/12/21.
//

import UIKit

extension UIViewController {
    static func loadFromNib() -> Self {
        Self.init(nibName: String(describing: Self.self), bundle: nil)
    }
}
