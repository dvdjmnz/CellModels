//
//  MainViewController.swift
//  CellModels
//
//  Created by David Jiménez Guinaldo on 12/12/21.
//

import RxCocoa
import RxSwift
import UIKit

final class MainViewController: UIViewController {
    var viewModel: ViewModelProtocol?

    private let disposeBag = DisposeBag()

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(
                .banner,
                .element,
                .elementsHorizontalContainer,
                .segmentedMenu
            )
            tableView.separatorStyle = .none
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBindings()
    }

    private func setUpBindings() {
        guard let viewModelInput = viewModel?.input as? MainViewModelInputProtocol,
            let viewModelOutput = viewModel?.output as? MainViewModelOutputProtocol else {
            return
        }

        tableView.rx.modelSelected(CellModel.self)
            .observe(on: MainScheduler.instance)
            .bind(to: viewModelInput.modelSelected)
            .disposed(by: disposeBag)

        viewModelOutput.dataSource
            .bind(to: tableView.rx.items) { tableView, row, cellModel -> UITableViewCell in
                let indexPath = IndexPath.init(row: row, section: 0)
                let cellBuilder = CellBuilder(tableView: tableView)
                return cellBuilder.build(with: cellModel, indexPath: indexPath)
            }
            .disposed(by: disposeBag)
    }
}

