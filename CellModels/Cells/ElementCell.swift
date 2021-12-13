//
//  ElementCell.swift
//  CellModels
//
//  Created by David Jiménez Guinaldo on 12/12/21.
//

import UIKit

struct ElementCellModel: CellModel {
    let identifier: CellIdentifier = .element

    var element: Element
}

class ElementCell: UITableViewCell, CellModelConfigurable {
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.roundedCorners()
            containerView.addShadow(
                color: .black,
                opacity: 0.15,
                shadowOffset: CGSize(width: 0, height: 2),
                shadowRadius: 2
            )
            containerView.clipsToBounds = true
        }
    }

    @IBOutlet weak var backgroundImageView: UIImageView! {
        didSet {
            backgroundImageView.image = .elementBackground
            backgroundImageView.contentMode = .scaleAspectFill
            backgroundImageView.alpha = 0.5
        }
    }

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = .black.withAlphaComponent(0.5)
            titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        resetStyle()
    }

    func configure(with cellModel: ElementCellModel) {
        titleLabel.text = cellModel.element.name
    }
}
