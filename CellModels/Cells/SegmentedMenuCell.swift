//
//  SegmentedMenuCell.swift
//  CellModels
//
//  Created by David Jiménez Guinaldo on 12/12/21.
//

import RxSwift
import UIKit

enum SortingOption: Int, CaseIterable {
    case unsorted
    case aToZ
    case zToA

    var title: String {
        switch self {
        case .unsorted:
            return "Unsorted"
        case .aToZ:
            return "A to Z"
        case .zToA:
            return "Z to A"
        }
    }
}

struct SegmentedMenuCellModel: CellModel {
    let identifier: CellIdentifier = .segmentedMenu

    var currentOption: SortingOption
    var optionSelected: BehaviorSubject<SortingOption>
}

class SegmentedMenuCell: UITableViewCell, CellModelConfigurable {
    @IBOutlet weak var segmentedControl: UISegmentedControl! {
        didSet {
            segmentedControl.setTitleTextAttributes(
                [NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.6)],
                for: .normal
            )
        }
    }

    private var disposeBag: DisposeBag = DisposeBag()

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        resetStyle()
    }

    func configure(with cellModel: SegmentedMenuCellModel) {
        segmentedControl.setSegments(
            segments: SortingOption.allCases.map(\.title),
            selectedIndex: cellModel.currentOption.rawValue
        )

        segmentedControl.rx.controlEvent(.valueChanged)
            .withUnretained(segmentedControl)
            .compactMap { SortingOption(rawValue: $0.0.selectedSegmentIndex) }
            .bind(to: cellModel.optionSelected)
            .disposed(by: disposeBag)
    }
}
