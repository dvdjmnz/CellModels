//
//  ViewModelProtocol.swift
//  CellModels
//
//  Created by David Jiménez Guinaldo on 12/12/21.
//

import RxSwift

protocol ViewModelInputProtocol {}

protocol ViewModelOutputProtocol {}

protocol ViewModelProtocol {
    var disposeBag: DisposeBag { get }
    var input: ViewModelInputProtocol { get }
    var output: ViewModelOutputProtocol { get }
}
