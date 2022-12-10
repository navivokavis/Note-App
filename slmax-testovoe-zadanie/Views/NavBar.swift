//
//  NavBar.swift
//  slmax-testovoe-zadanie
//
//  Created by Navi Vokavis on 2.12.22.
//

import UIKit

class NavBar: UIView {
    
    var hatImage = UIImageView()
    var hatTextLable = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        buildHierarchy()
        configureSubviews()
        layoutConstraint()
    }
    
    func buildHierarchy() {
        setupViews(hatImage)
        setupViews(hatTextLable)
    }
    
    func configureSubviews() {
        hatImage.image = Resources.Images.hatImage
        hatImage.contentMode = .scaleAspectFill
        
        hatTextLable.text = LocalizedString.NavBar.hatString
        hatTextLable.font = Resources.Fonts.RalewaySemiBold(with: 28)
        hatTextLable.textColor = Resources.Colors.whiteText
        
    }
    
    func layoutConstraint() {
        NSLayoutConstraint.activate([
            hatImage.topAnchor.constraint(equalTo: topAnchor),
            hatImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            hatImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            hatTextLable.topAnchor.constraint(equalTo: hatImage.topAnchor, constant: 80),
            hatTextLable.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
}
