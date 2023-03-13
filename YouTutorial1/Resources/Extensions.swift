//
//  Extensions.swift
//  YouTutorial1
//
//  Created by Bruce Fraser on 3/9/23.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { v in
            addSubview(v)
        }
    }
}
