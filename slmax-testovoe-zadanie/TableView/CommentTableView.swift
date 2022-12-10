//
//  CommentTableView.swift
//  slmax-testovoe-zadanie
//
//  Created by Navi Vokavis on 6.12.22.
//

import UIKit

class CommentTableView: UIView {
        
    var commentTableView = SelfSizingTableView(frame: .zero, style: .grouped)
    
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
    
//    func reloadTable() {
//        commentTableView.reloadData()
//    }
    
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
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CommentTableViewCell.identifier,
            for: indexPath)
                as? CommentTableViewCell else {
            fatalError()
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
