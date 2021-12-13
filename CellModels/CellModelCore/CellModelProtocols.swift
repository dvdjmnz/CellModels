//
//  CellModelProtocols.swift
//  CellModels
//
//  Created by David Jiménez Guinaldo on 12/12/21.
//

import UIKit

protocol CellModel {
    var identifier: CellIdentifier { get }
}

protocol CellModelConfigurable: UITableViewCell {
    associatedtype CustomCellModel: CellModel
    func configure(with cellModel: CustomCellModel)
}
