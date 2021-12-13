//
//  SceneBuilder.swift
//  CellModels
//
//  Created by David Jiménez Guinaldo on 12/12/21.
//

import UIKit

struct SceneBuilder {
    enum Scenes {
        case main
    }

    static func build(_ scene: Scenes) -> UIViewController {
        switch scene {
        case .main:
            let viewModel = MainViewModel()
            let view = MainViewController.loadFromNib()
            view.viewModel = viewModel
            return view
        }
    }
}
