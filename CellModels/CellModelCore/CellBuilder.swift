//
//  CellBuilder.swift
//  CellModels
//
//  Created by David Jiménez Guinaldo on 12/12/21.
//

import UIKit

class CellBuilder {
    let tableView: UITableView

    init(tableView: UITableView) {
        self.tableView = tableView
    }

    func build(with cellModel: CellModel, indexPath: IndexPath) -> UITableViewCell {
        switch cellModel.identifier {
        case .banner: return configure(indexPath: indexPath, cellModel: cellModel, cellClass: BannerCell.self)
        case .element: return configure(indexPath: indexPath, cellModel: cellModel, cellClass: ElementCell.self)
        case .elementsHorizontalContainer: return configure(indexPath: indexPath, cellModel: cellModel, cellClass: ElementsHorizontalContainerCell.self)
        case .segmentedMenu: return configure(indexPath: indexPath, cellModel: cellModel, cellClass: SegmentedMenuCell.self)
        }
    }

    private func configure<Cell: CellModelConfigurable, CellModel>(indexPath: IndexPath, cellModel: CellModel, cellClass: Cell.Type) -> Cell {
        guard let cellModel = cellModel as? Cell.CustomCellModel else { fatalError("cellModel class doesn't match with cell's CellModel") }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.identifier.rawValue, for: indexPath) as! Cell
        cell.configure(with: cellModel)
        return cell
    }
}
