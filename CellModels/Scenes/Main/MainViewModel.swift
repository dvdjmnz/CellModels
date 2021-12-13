//
//  MainViewModel.swift
//  CellModels
//
//  Created by David Jiménez Guinaldo on 12/12/21.
//

import RxSwift

protocol MainViewModelInputProtocol: ViewModelInputProtocol {
    var modelSelected: AnyObserver<CellModel> { get }
}

struct MainInput: MainViewModelInputProtocol {
    var modelSelected: AnyObserver<CellModel>
}

protocol MainViewModelOutputProtocol: ViewModelOutputProtocol {
    var dataSource: Observable<[CellModel]> { get }
}

struct MainOutput: MainViewModelOutputProtocol {
    var dataSource: Observable<[CellModel]>
}

final class MainViewModel: ViewModelProtocol, DataSourceBuildable {
    let disposeBag = DisposeBag()

    var input: ViewModelInputProtocol
    var output: ViewModelOutputProtocol

    var dataSourceSubject = BehaviorSubject<[CellModel]>(value: [])
    private let modelSelectedSubject = PublishSubject<CellModel>()
    private var sortingOptionHorizontalSubject = BehaviorSubject<SortingOption>(value: .unsorted)
    private var sortingOptionVerticalSubject = BehaviorSubject<SortingOption>(value: .unsorted)
    private var didTapCloseBannerSubject = PublishSubject<Void>()
    private var showBannerSubject = BehaviorSubject<Bool>(value: true)
    private var elementSelectedSubject = PublishSubject<Element>()
    private var refreshHorizontalElements = PublishSubject<[Element]>()

    private var elements: [Element] = [
        Element(name: "Element 2"),
        Element(name: "Element 1"),
        Element(name: "Element 5"),
        Element(name: "Element 3"),
        Element(name: "Element 4")
    ]

    init() {
        input = MainInput(modelSelected: modelSelectedSubject.asObserver())
        output = MainOutput(dataSource: dataSourceSubject.observe(on: MainScheduler.instance))

        setupRx()
    }

    private func setupRx() {
        let updateState = PublishSubject<Void>()

        updateState
            .withLatestFrom(
                Observable.combineLatest(
                    sortingOptionHorizontalSubject,
                    sortingOptionVerticalSubject,
                    showBannerSubject
                )
            )
            .withUnretained(self)
            .subscribe(onNext: { owner, data in
                owner.configureDataSource(
                    sortingOptionHorizontal: data.0,
                    sortingOptionVertical: data.1,
                    showBanner: data.2
                )
            })
            .disposed(by: disposeBag)

        sortingOptionVerticalSubject
            .map { _ in () }
            .bind(to: updateState)
            .disposed(by: disposeBag)

        didTapCloseBannerSubject
            .withUnretained(self)
            .subscribe(onNext: {
                $0.0.showBannerSubject.onNext(false)
                updateState.onNext(())
            })
            .disposed(by: disposeBag)

        modelSelectedSubject
            .compactMap { $0 as? ElementCellModel }
            .map(\.element)
            .bind(to: elementSelectedSubject)
            .disposed(by: disposeBag)

        elementSelectedSubject
            .do(onNext: {
                print("\($0.name) with id \($0.id) tapped")
            })
            .subscribe()
            .disposed(by: disposeBag)

        sortingOptionHorizontalSubject
            .withUnretained(self)
            .map { owner, sortingOption in
                switch sortingOption {
                case .unsorted:
                    return owner.elements
                case .aToZ:
                    return owner.elements.sorted(by: { $0.name < $1.name })
                case .zToA:
                    return owner.elements.sorted(by: { $0.name > $1.name })
                }
            }
            .bind(to: refreshHorizontalElements)
            .disposed(by: disposeBag)
    }

    private func configureDataSource(sortingOptionHorizontal: SortingOption, sortingOptionVertical: SortingOption, showBanner: Bool) {
        build {
            if showBanner {
                BannerCellModel(didTapClose: didTapCloseBannerSubject.asObserver())
            }
            
            SegmentedMenuCellModel(
                currentOption: sortingOptionHorizontal,
                optionSelected: sortingOptionHorizontalSubject.asObserver()
            )

            switch sortingOptionHorizontal {
            case .unsorted:
                ElementsHorizontalContainerCellModel(
                    elements: elements,
                    didSelectElement: elementSelectedSubject.asObserver(),
                    shouldRefresh: refreshHorizontalElements
                )
            case .aToZ:
                let elements = elements.sorted(by: { $0.name < $1.name })
                ElementsHorizontalContainerCellModel(
                    elements: elements,
                    didSelectElement: elementSelectedSubject.asObserver(),
                    shouldRefresh: refreshHorizontalElements
                )
            case .zToA:
                let elements = elements.sorted(by: { $0.name > $1.name })
                ElementsHorizontalContainerCellModel(
                    elements: elements,
                    didSelectElement: elementSelectedSubject.asObserver(),
                    shouldRefresh: refreshHorizontalElements
                )
            }

            SegmentedMenuCellModel(
                currentOption: sortingOptionVertical,
                optionSelected: sortingOptionVerticalSubject.asObserver()
            )

            switch sortingOptionVertical {
            case .unsorted:
                for element in elements {
                    ElementCellModel(element: element)
                }
            case .aToZ:
                let elements = elements.sorted(by: { $0.name < $1.name })
                for element in elements {
                    ElementCellModel(element: element)
                }
            case .zToA:
                let elements = elements.sorted(by: { $0.name > $1.name })
                for element in elements {
                    ElementCellModel(element: element)
                }
            }
        }
    }
}
