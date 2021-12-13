//
//  UIView+Extensions.swift
//  CellModels
//
//  Created by David Jiménez Guinaldo on 13/12/21.
//

import UIKit

extension UIView {
    func roundedCorners(radius: CGFloat = 4) {
        layer.cornerRadius = radius
    }

    func addShadow(color: UIColor = .black,
                   opacity: Float = 0.15,
                   shadowOffset: CGSize = CGSize(width: 0, height: 2),
                   shadowRadius: CGFloat = 2) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
}
