//
//  MainViewController.swift
//  slmax-testovoe-zadanie
//
//  Created by Navi Vokavis on 2.12.22.
//

import UIKit

class MainViewController: UIViewController {
    
    var navBar = NavBar()
    var tableView = NotesTableView()
    var addNoteView = AddNoteView()
    var mainNoteView = MainNoteView()
    var notesArray: [Note] = []
    
    var newNoteBottomConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup() {
        buildHierarchy()
        configureSubviews()
        layoutConstraint()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func buildHierarchy() {
        view.setupViews(navBar)
        view.setupViews(tableView)
        view.setupViews(addNoteView)
    }
    
    func configureSubviews() {
        view.backgroundColor = .white
        
        // обрабатываю замыкание и ловлю новую заметку
        addNoteView.addNewNote = { [weak self] note in
            guard let self = self else { return }
            self.notesArray.append(note)
            
            self.tableView.newArrayFromNotesArray = self.notesArray
            print(self.tableView.newArrayFromNotesArray)
        }
        
        tableView.deleteCell = { [weak self] deletedTitle in
            guard let self = self else { return }
            
            if let index = self.notesArray.firstIndex(where: {$0.title == deletedTitle}) {
                self.notesArray.remove(at: index)
                self.tableView.newArrayFromNotesArray = self.notesArray
            }
        }
        
//                mainNoteView.sectionIsOpen = { [weak self] changeBool in
//                    guard let self = self else { return }
//                    self.notesArray[0].open
//
//                }
    }
    
    func layoutConstraint() {
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 200),
            
            tableView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: addNoteView.topAnchor, constant: -20),
            
            
            addNoteView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            addNoteView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
            //        lowerNoteView.heightAnchor.constraint(equalToConstant: 200),
        ])
        
        newNoteBottomConstraint = addNoteView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        newNoteBottomConstraint.isActive = true
    }
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if newNoteBottomConstraint.constant == -40 {
                UIView.animate(withDuration: 0.4) {
                    self.newNoteBottomConstraint.constant -= keyboardSize.height
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if newNoteBottomConstraint.constant != -40 {
            UIView.animate(withDuration: 0.4) {
                self.newNoteBottomConstraint.constant = -40
                self.view.layoutIfNeeded()
            }
        }
    }
    
}



//hide keyboard by tap
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


