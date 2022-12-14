//
//  CommentTableView.swift
//  slmax-testovoe-zadanie
//
//  Created by Navi Vokavis on 6.12.22.
//

import UIKit

//size of tableView
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



class CommentTableView: UIView {
        
    var commentTableView = SelfSizingTableView(frame: .zero, style: .grouped)
    var commentArray: [Comment] = []{
        didSet{
            commentTableView.reloadData()
        }
    }
    
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
        setupViews(commentTableView)
    }
    
    func configureSubviews() {
        commentTableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier)
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentTableView.separatorColor = .clear
        commentTableView.backgroundColor = .white
        commentTableView.showsVerticalScrollIndicator = false
        
        commentTableView.sectionHeaderHeight = 0
    }
    
    func layoutConstraint() {
        NSLayoutConstraint.activate([
            commentTableView.topAnchor.constraint(equalTo: topAnchor),
            commentTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            commentTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            commentTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30)
        ])
    }
    
}

//MARK: - TableView Delegate and DataSource
extension CommentTableView: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Section
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    
    //MARK: - Row
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CommentTableViewCell.identifier,
            for: indexPath)
                as? CommentTableViewCell else {
            fatalError()
        }
        
        let rowData = commentArray[indexPath.row]
        cell.commentTitleLabel.text = rowData.commentTitle
        cell.commentDescriptionLabel.text = rowData.commentDescription
        cell.commentDateLabel.text = rowData.commentDate
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
