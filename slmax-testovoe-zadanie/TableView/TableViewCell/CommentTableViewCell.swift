//
//  CommentTableViewCell.swift
//  slmax-testovoe-zadanie
//
//  Created by Navi Vokavis on 6.12.22.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    static let identifier = "FirstCommentTableViewCell"
    var commentTitleLabel = UILabel()
    var commentDescriptionLabel = UILabel()
    var commentDateLabel = UILabel()
//    var answerOnCommentButton = UIButton()
   

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setup() {
        buildHierarchy()
        configureSubviews()
        layoutConstraint()
    }
    
    func buildHierarchy() {
        contentView.setupViews(commentTitleLabel)
        contentView.setupViews(commentDescriptionLabel)
        contentView.setupViews(commentDateLabel)
//        contentView.setupViews(answerOnCommentButton)
    }
    
    func configureSubviews() {
        
        selectionStyle = .none
        
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 5
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = Resources.Colors.separate.cgColor
        
        commentTitleLabel.textColor = Resources.Colors.blackText
        commentTitleLabel.font = Resources.Fonts.RalewaySemiBold(with: 14)
        
        commentDescriptionLabel.numberOfLines = 0
        commentDescriptionLabel.lineBreakMode = .byWordWrapping
        commentDescriptionLabel.textColor = Resources.Colors.blackText
        commentDescriptionLabel.font = Resources.Fonts.RalewayLight(with: 12)
        
        commentDateLabel.textColor = Resources.Colors.dateTextColor
        commentDateLabel.font = Resources.Fonts.RalewayLight(with: 7)
        
//        answerOnCommentButton.setTitle("Ответить", for: .normal)
//        answerOnCommentButton.setTitleColor(Resources.Colors.dateTextColor, for: .normal)
//        answerOnCommentButton.titleLabel?.font = Resources.Fonts.RalewaySemiBold(with: 7)
                
    }
    
    func layoutConstraint() {
        NSLayoutConstraint.activate([
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: commentDateLabel.bottomAnchor, constant: 7),
            
            commentTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 11),
            commentTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 11),
            commentTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -11),
            
            commentDescriptionLabel.topAnchor.constraint(equalTo: commentTitleLabel.bottomAnchor, constant: 8),
            commentDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -11),
            commentDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 11),
            
            commentDateLabel.topAnchor.constraint(equalTo: commentDescriptionLabel.bottomAnchor, constant: 5),
            commentDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 11),
            commentDateLabel.heightAnchor.constraint(equalToConstant: 7)
            
//            answerOnCommentButton.centerYAnchor.constraint(equalTo: commentDateLabel.centerYAnchor),
//            answerOnCommentButton.leadingAnchor.constraint(equalTo: commentDateLabel.trailingAnchor, constant: 10),

        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 3, left: 0, bottom: 3, right: 0))
    }
    
}
