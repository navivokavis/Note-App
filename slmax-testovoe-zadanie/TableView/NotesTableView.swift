//
//  NotesTableView.swift
//  slmax-testovoe-zadanie
//
//  Created by Navi Vokavis on 2.12.22.
//

import UIKit
import RxSwift

class NotesTableView: UIView {
        
    var notesTableView = UITableView(frame: .zero, style: .grouped)
    var notesArray = [Note]() {
        didSet {
            self.notesTableView.reloadData()
        }
    }
    
    var bag = DisposeBag()
    
    
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
        setupViews(notesTableView)
    }
    
    func configureSubviews() {
        notesTableView.register(NotesTableViewCell.self, forCellReuseIdentifier: NotesTableViewCell.identifier)
        notesTableView.delegate = self
        notesTableView.dataSource = self
        notesTableView.separatorColor = .clear
        notesTableView.backgroundColor = Resources.Colors.whiteBackground
        notesTableView.showsVerticalScrollIndicator = false
        
    }
    
    func layoutConstraint() {
        NSLayoutConstraint.activate([
            notesTableView.topAnchor.constraint(equalTo: topAnchor),
            notesTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            notesTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            notesTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30)
        ])
    }
    
    func reloadTable() {
        notesTableView.reloadData()
    }
    
//    @objc func addCommentButtonTapped() {
//        print("SD")
//        var addCommentView = AddCommentView()
//        setupViews(addCommentView)
//        addCommentView.alpha = 0
//
//        NSLayoutConstraint.activate([
//            addCommentView.topAnchor.constraint(equalTo: topAnchor),
//            addCommentView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            addCommentView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            addCommentView.leadingAnchor.constraint(equalTo: leadingAnchor)
//        ])
//
//        if addCommentView.alpha == 0 {
//            addCommentView.alpha = 1
//        } else {
//            addCommentView.alpha = 0
//        }
//    }
//
//    @objc func backgroundTapped() {
//        print("dfds")
//        var addCommentView = AddCommentView()
//        addCommentView.alpha = 0
//    }
    
}

//MARK: - TableView Delegate and DataSource

extension NotesTableView: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Section
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let noteView = MainNoteView()
        
        noteView.tag = section
        
        //MARK: delete section with RxSwift
        
        noteView.deleteSectionObservable.subscribe { [weak self] event in
            guard let self = self else { return }
            if let index = self.notesArray.firstIndex(where: {$0.title == event}) {
                self.notesArray.remove(at: index)
            }
        }.disposed(by: bag)
        
        //MARK: open-close with RxSwift
        
        noteView.tagObservable.subscribe { [weak self] event in
            print(event)
            
            let isOpen = self!.notesArray[event].isOpen
            print(isOpen)
            self!.notesArray[event].isOpen = !isOpen
            print(self!.notesArray)

        }.disposed(by: bag)
        
        noteView.headerLabel.text = notesArray[section].title
        noteView.notesLabel.text = notesArray[section].description
        return noteView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        37
    }
    
    
    //MARK: Row
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowNumber = 0
        if !notesArray[section].isOpen {
            rowNumber = 0
        } else {
            rowNumber = 1
        }
        return rowNumber
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NotesTableViewCell.identifier,
            for: indexPath)
                as? NotesTableViewCell else {
            fatalError()
        }
        
        cell.getComment = { [weak self] newComment in
            self?.notesArray[indexPath.section].comment.append(newComment)
            self?.reloadTable()
        }
//        cell.note = notesArray[indexPath.section]
        cell.setupCell(note: notesArray[indexPath.section])
//        cell.fullDescriptionLabel.text = rowData.description
//        cell.dateLabel.text = rowData.time
//        cell.commentTableView.commentArray = rowData.comment
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
}

