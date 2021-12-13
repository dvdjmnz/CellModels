//
//  CollectionCellBuilder.swift
//  CellModels
//
//  Created by David Jiménez Guinaldo on 13/12/21.
//

import UIKit

class CollectionCellBuilder {
    let collectionView: UICollectionView

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }

    func build(with cellModel: CollectionCellModel, indexPath: IndexPath) -> UICollectionViewCell {
        switch cellModel.identifier {
        case .element: return configure(indexPath: indexPath, cellModel: cellModel, cellClass: ElementCollectionCell.self)
        }
    }

    private func configure<Cell: CollectionCellModelConfigurable, CellModel>(indexPath: IndexPath, cellModel: CellModel, cellClass: Cell.Type) -> Cell {
        guard let cellModel = cellModel as? Cell.CustomCellModel else { fatalError("cellModel class doesn't match with cell's CellModel") }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellModel.identifier.rawValue, for: indexPath) as! Cell
        cell.configure(with: cellModel)
        return cell
    }
}
