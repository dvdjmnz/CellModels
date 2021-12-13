//
//  UISegmentedControl+Extensions.swift
//  CellModels
//
//  Created by David Jiménez Guinaldo on 13/12/21.
//

import UIKit

extension UISegmentedControl {
    func setSegments(segments: [String], selectedIndex: Int) {
        removeAllSegments()
        for (index, segment) in segments.enumerated() {
            insertSegment(withTitle: segment, at: index, animated: false)
        }
        selectedSegmentIndex = selectedIndex
    }
}
