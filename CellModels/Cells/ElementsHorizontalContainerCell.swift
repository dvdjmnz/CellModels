//
//  ElementsHorizontalContainerCell.swift
//  CellModels
//
//  Created by David Jiménez Guinaldo on 13/12/21.
//

import RxSwift
import UIKit

struct ElementsHorizontalContainerCellModel: CellModel {
    let identifier: CellIdentifier = .elementsHorizontalContainer

    var elements: [Element]
    let didSelectElement: AnyObserver<Element>
    let shouldRefresh: Observable<[Element]>
}

class ElementsHorizontalContainerCell: UITableViewCell, CellModelConfigurable, CollectionDataSourceBuildable {
    var dataSourceSubject = BehaviorSubject<[CollectionCellModel]>(value: [])

    private var disposeBag: DisposeBag = DisposeBag()

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(.element)
        }
    }

    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout! {
        didSet {
            collectionViewFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    func configure(with cellModel: ElementsHorizontalContainerCellModel) {
        var cellModel = cellModel
        build {
            for element in cellModel.elements {
                ElementCollectionCellModel(element: element)
            }
        }

        collectionView.rx.modelSelected(ElementCollectionCellModel.self)
            .map(\.element)
            .bind(to: cellModel.didSelectElement)
            .disposed(by: disposeBag)

        cellModel.shouldRefresh
            .withUnretained(self)
            .subscribe(onNext: { owner, elements in
                cellModel.elements = elements
                owner.build {
                    for element in cellModel.elements {
                        ElementCollectionCellModel(element: element)
                    }
                }
            })
            .disposed(by: disposeBag)

        dataSourceSubject
            .bind(to: collectionView.rx.items) { collectionView, row, cellModel -> UICollectionViewCell in
                let indexPath = IndexPath.init(row: row, section: 0)
                let cellBuilder = CollectionCellBuilder(collectionView: collectionView)
                return cellBuilder.build(with: cellModel, indexPath: indexPath)
            }
            .disposed(by: disposeBag)
    }
}
