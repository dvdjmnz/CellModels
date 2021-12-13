//
//  DataSourceBuildable.swift
//  CellModels
//
//  Created by David Jiménez Guinaldo on 13/12/21.
//

import RxSwift

protocol DataSourceBuildable {
    var dataSourceSubject: BehaviorSubject<[CellModel]> { get }
}

extension DataSourceBuildable {
    func build(@DataSourceBuilder cellModels: () -> [CellModel]) {
        dataSourceSubject.onNext(cellModels())
    }
}

protocol CollectionDataSourceBuildable {
    var dataSourceSubject: BehaviorSubject<[CollectionCellModel]> { get }
}

extension CollectionDataSourceBuildable {
    func build(@CollectionDataSourceBuilder cellModels: () -> [CollectionCellModel]) {
        dataSourceSubject.onNext(cellModels())
    }
}
