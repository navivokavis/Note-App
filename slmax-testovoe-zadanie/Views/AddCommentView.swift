//
//  AddCommentView.swift
//  slmax-testovoe-zadanie
//
//  Created by Navi Vokavis on 8.12.22.
//

import UIKit

class AddCommentView: UIView {
    
    var backgroundView = UIButton()
    var windowView = UIView()
    var titleTextLabel = UILabel()
    var commentTitleTextField = UITextField()
    var commentDescriptionTextView = UITextView()
    var addCommentButton = UIButton()
    
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
        setupViews(backgroundView)
        setupViews(windowView)
        windowView.setupViews(titleTextLabel)
        windowView.setupViews(commentTitleTextField)
        windowView.setupViews(commentDescriptionTextView)
        windowView.setupViews(addCommentButton)
    }
    
    func configureSubviews() {
        backgroundView.backgroundColor = Resources.Colors.blackText
        backgroundView.alpha = 0.3
        
        windowView.backgroundColor = Resources.Colors.whiteBackground
        windowView.layer.cornerRadius = 5
        
        titleTextLabel.text = LocalizedString.AddCommentView.titleTextLabel
        titleTextLabel.font = Resources.Fonts.RalewaySemiBold(with: 15)
        titleTextLabel.textAlignment = .center
        
        commentTitleTextField.placeholder = LocalizedString.AddCommentView.commentTitleTextField
        commentTitleTextField.font = Resources.Fonts.RalewayLight(with: 15)
        commentTitleTextField.layer.cornerRadius = 5
        commentTitleTextField.layer.borderWidth = 1
        commentTitleTextField.layer.borderColor = Resources.Colors.separate.cgColor
        
        commentDescriptionTextView.layer.cornerRadius = 5
        commentDescriptionTextView.layer.borderColor = Resources.Colors.separate.cgColor
        commentDescriptionTextView.font = Resources.Fonts.RalewayLight(with: 15)
        commentDescriptionTextView.layer.borderWidth = 1
        commentDescriptionTextView.text = LocalizedString.AddCommentView.commentDescriptionTextView
        commentDescriptionTextView.textColor = UIColor.lightGray
        commentDescriptionTextView.delegate = self
        
        addCommentButton.setImage(Resources.Images.paperplaneFill?.withRenderingMode(.alwaysTemplate), for: .normal)
        addCommentButton.tintColor = Resources.Colors.addCommentGray
        
        backgroundView.addTarget(self, action: #selector(hideView), for: .touchUpInside)
        
    }
    
    @objc func hideView() {
        self.endEditing(true)
        // выбрасываю значение которое было введено if need
        
        self.removeFromSuperview()
    }
    
    func layoutConstraint() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            windowView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            windowView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            windowView.widthAnchor.constraint(equalToConstant: 300),
            windowView.heightAnchor.constraint(equalToConstant: 200),
            
            titleTextLabel.topAnchor.constraint(equalTo: windowView.topAnchor, constant: 8),
            titleTextLabel.leadingAnchor.constraint(equalTo: windowView.leadingAnchor, constant: 10),
            titleTextLabel.trailingAnchor.constraint(equalTo: windowView.trailingAnchor, constant: -10),
            
            commentTitleTextField.topAnchor.constraint(equalTo: titleTextLabel.bottomAnchor, constant: 10),
            commentTitleTextField.leadingAnchor.constraint(equalTo: windowView.leadingAnchor, constant: 10),
            commentTitleTextField.trailingAnchor.constraint(equalTo: addCommentButton.leadingAnchor, constant: -5),
            
            addCommentButton.topAnchor.constraint(equalTo: commentTitleTextField.topAnchor),
            addCommentButton.widthAnchor.constraint(equalToConstant: 30),
            addCommentButton.trailingAnchor.constraint(equalTo: windowView.trailingAnchor, constant: -5),
            
            commentDescriptionTextView.topAnchor.constraint(equalTo: commentTitleTextField.bottomAnchor, constant: 8),
            commentDescriptionTextView.leadingAnchor.constraint(equalTo: windowView.leadingAnchor, constant: 10),
            commentDescriptionTextView.trailingAnchor.constraint(equalTo: windowView.trailingAnchor, constant: -10),
            commentDescriptionTextView.bottomAnchor.constraint(equalTo: windowView.bottomAnchor, constant: -8)
        ])
    }
    
    
}

extension AddCommentView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if commentDescriptionTextView.textColor == UIColor.lightGray {
            commentDescriptionTextView.text = nil
            commentDescriptionTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if commentDescriptionTextView.text.isEmpty {
            commentDescriptionTextView.text = "Placeholder"
            commentDescriptionTextView.textColor = UIColor.lightGray
        }
    }
    
}
