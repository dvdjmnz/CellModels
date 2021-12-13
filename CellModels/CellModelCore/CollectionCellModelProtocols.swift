//
//  CollectionCellModelProtocols.swift
//  CellModels
//
//  Created by David Jiménez Guinaldo on 13/12/21.
//

import UIKit

protocol CollectionCellModel {
    var identifier: CollectionCellIdentifier { get }
}

protocol CollectionCellModelConfigurable: UICollectionViewCell {
    associatedtype CustomCellModel: CollectionCellModel
    func configure(with cellModel: CustomCellModel)
}

