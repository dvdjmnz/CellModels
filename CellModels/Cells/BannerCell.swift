//
//  BannerCell.swift
//  CellModels
//
//  Created by David Jiménez Guinaldo on 13/12/21.
//

import RxSwift
import UIKit

struct BannerCellModel: CellModel {
    let identifier: CellIdentifier = .banner

    var didTapClose: AnyObserver<Void>
}

class BannerCell: UITableViewCell, CellModelConfigurable {
    private var disposeBag: DisposeBag = DisposeBag()

    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.roundedCorners()
            containerView.clipsToBounds = true
        }
    }

    @IBOutlet weak var backgroundImageView: UIImageView! {
        didSet {
            backgroundImageView.image = .bannerBackground
            backgroundImageView.contentMode = .scaleAspectFill
        }
    }

    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = "Promo Banner"
            titleLabel.textColor = .black.withAlphaComponent(0.5)
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        }
    }

    @IBOutlet weak var closeButton: UIButton!

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        resetStyle()
    }

    func configure(with cellModel: BannerCellModel) {
        closeButton.rx.tap
            .bind(to: cellModel.didTapClose)
            .disposed(by: disposeBag)
    }
}
