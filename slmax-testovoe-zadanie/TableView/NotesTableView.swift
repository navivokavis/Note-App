//
//  NotesTableView.swift
//  slmax-testovoe-zadanie
//
//  Created by Navi Vokavis on 2.12.22.
//

import UIKit

class NotesTableView: UIView {
    
    var deleteCell: ((String) -> Void)?
    
    var notesTableView = UITableView(frame: .zero, style: .grouped)
    var newArrayFromNotesArray = [Note]() {
        didSet {
            self.notesTableView.reloadData()
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
        setupViews(notesTableView)
    }
    
    func configureSubviews() {
        notesTableView.register(NotesTableViewCell.self, forCellReuseIdentifier: NotesTableViewCell.identifier)
        notesTableView.delegate = self
        notesTableView.dataSource = self
        notesTableView.separatorColor = .clear
        notesTableView.backgroundColor = .white
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
    
    // func to open-close section
    func changeBool(tag: Int) {
        
        let isOpen = newArrayFromNotesArray[tag].isOpen
        newArrayFromNotesArray[tag].isOpen = !isOpen
        
    }
    
}

//MARK: - TableView Delegate and DataSource
extension NotesTableView: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Section
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return newArrayFromNotesArray.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let noteView = MainNoteView()
        
        noteView.tag = section
        
        //delete section with closure
        noteView.deleteCell = { [weak self] deleteTitle in
            self?.deleteCell?(deleteTitle)
        }
        
        //open-clouse with closure
        noteView.sectionIsOpen = { [weak self] change in
            self?.changeBool(tag: change)
        }
        
        noteView.headerLabel.text = newArrayFromNotesArray[section].title
        noteView.notesLabel.text = newArrayFromNotesArray[section].description
        return noteView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        37
    }
    
    
    //MARK: - Row
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowNumber = 0
        if !newArrayFromNotesArray[section].isOpen {
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
        
        let rowData = newArrayFromNotesArray[indexPath.section]
        cell.fullDescriptionLabel.text = rowData.description
        cell.dateLabel.text = rowData.time
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
}

