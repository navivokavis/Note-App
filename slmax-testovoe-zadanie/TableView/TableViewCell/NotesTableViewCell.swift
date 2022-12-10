//
//  NotesTableViewCell.swift
//  slmax-testovoe-zadanie
//
//  Created by Navi Vokavis on 2.12.22.
//

import UIKit
import RxSwift

class NotesTableViewCell: UITableViewCell {
    
    static let identifier = "NotesTableViewCell"
    var dateLabel = UILabel()
    var fullDescriptionLabel = UILabel()
    var addCommentButton = UIButton()
    
    var commentTableView = CommentTableView()
    var obs = PublishSubject<Selector>()

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
        contentView.setupViews(dateLabel)
        contentView.setupViews(fullDescriptionLabel)
        contentView.setupViews(addCommentButton)
        contentView.setupViews(commentTableView)
    }
    
    func configureSubviews() {
        
        selectionStyle = .none
        
        dateLabel.textColor = Resources.Colors.dateTextColor
        dateLabel.font = Resources.Fonts.RalewayLight(with: 8)
        
        fullDescriptionLabel.numberOfLines = 0
        fullDescriptionLabel.lineBreakMode = .byWordWrapping
        fullDescriptionLabel.font = Resources.Fonts.RalewayLight(with: 10)
        
        addCommentButton.setImage(Resources.Images.plus?.withRenderingMode(.alwaysTemplate), for: .normal)
        addCommentButton.tintColor = Resources.Colors.addCommentGray
//        addCommentButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapa)))
        addCommentButton.addTarget(self, action: #selector(addCommentButtonTapped), for: .touchUpInside)
        
    }
    
    func layoutConstraint() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: commentTableView.bottomAnchor),
            
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            
            addCommentButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 7),
            addCommentButton.centerXAnchor.constraint(equalTo: dateLabel.centerXAnchor),
//            addCommentButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -26),
//            addCommentButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17),
            
            fullDescriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 27),
            fullDescriptionLabel.trailingAnchor.constraint(equalTo: addCommentButton.leadingAnchor, constant: -6),
            fullDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17),
            
            commentTableView.topAnchor.constraint(equalTo: fullDescriptionLabel.bottomAnchor, constant: 25),
            commentTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            commentTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            commentTableView.heightAnchor.constraint(equalToConstant: 150),
            
//            addCommentView.topAnchor.constraint(equalTo: self.topAnchor),
//            addCommentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            addCommentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            addCommentView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    
//    func addCommentButtonTapped(_ action: Selector, with target: Any?) {
//        addCommentButton.addTarget(target, action: (action), for: .touchUpInside)
//    }

    @objc func addCommentButtonTapped() {
//        obs.on(#selector(addCommentButtonTapped))
        getRootNavigationController()?.showCommentView()
print("HI")
    }
    
}

class SelfSizingTableView: UITableView {
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsLayout()
        }
    }

    override var intrinsicContentSize: CGSize {
        let height = min(.infinity, contentSize.height)
        return CGSize(width: contentSize.width, height: height)
    }
}

    
