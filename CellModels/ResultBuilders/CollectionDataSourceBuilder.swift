//
//  CollectionDataSourceBuilder.swift
//  CollectionCellModels
//
//  Created by David Jiménez Guinaldo on 13/12/21.
//

import RxSwift

@resultBuilder
struct CollectionDataSourceBuilder {
    static func buildBlock(_ components: CollectionCellModel...) -> [CollectionCellModel] {
        components
    }

    static func buildBlock(_ components: [CollectionCellModel]...) -> [CollectionCellModel] {
        Array(components.joined())
    }

    static func buildEither(first component: [CollectionCellModel]) -> [CollectionCellModel] {
        component
    }

    static func buildEither(second component: [CollectionCellModel]) -> [CollectionCellModel] {
        component
    }

    static func buildOptional(_ component: [CollectionCellModel]?) -> [CollectionCellModel] {
        component ?? []
    }

    static func buildExpression(_ expression: CollectionCellModel) -> [CollectionCellModel] {
        [expression]
    }

    static func buildArray(_ components: [[CollectionCellModel]]) -> [CollectionCellModel] {
        Array(components.joined())
    }
}

