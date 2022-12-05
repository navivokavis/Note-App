//
//  UIView + ext.swift
//  slmax-testovoe-zadanie
//
//  Created by Navi Vokavis on 2.12.22.
//

import UIKit

extension UIView {
    
    func setupViews(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
