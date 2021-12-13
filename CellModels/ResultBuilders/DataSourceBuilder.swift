//
//  DataSourceBuilder.swift
//  CellModels
//
//  Created by David Jiménez Guinaldo on 12/12/21.
//

import RxSwift

@resultBuilder
struct DataSourceBuilder {
    static func buildBlock(_ components: CellModel...) -> [CellModel] {
        components
    }

    static func buildBlock(_ components: [CellModel]...) -> [CellModel] {
        Array(components.joined())
    }

    static func buildEither(first component: [CellModel]) -> [CellModel] {
        component
    }

    static func buildEither(second component: [CellModel]) -> [CellModel] {
        component
    }

    static func buildOptional(_ component: [CellModel]?) -> [CellModel] {
        component ?? []
    }

    static func buildExpression(_ expression: CellModel) -> [CellModel] {
        [expression]
    }

    static func buildArray(_ components: [[CellModel]]) -> [CellModel] {
        Array(components.joined())
    }
}
