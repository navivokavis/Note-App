//
//  MainViewController.swift
//  slmax-testovoe-zadanie
//
//  Created by Navi Vokavis on 2.12.22.
//

import UIKit
import RxSwift

class MainViewController: UIViewController {
    
    var navBar = NavBar()
    var tableView = NotesTableView()
    var addNoteView = AddNoteView()
    var mainNoteView = MainNoteView()
    
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
        view.backgroundColor = Resources.Colors.whiteBackground
        
        addNoteView.arrowButtonTapped(#selector(arrowButtonTapped), with: self)
    }
    
    func layoutConstraint() {
        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBar.heightAnchor.constraint(equalToConstant: 200),
            
            tableView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 21),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: addNoteView.topAnchor, constant: -20),
            
            addNoteView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            addNoteView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        
        newNoteBottomConstraint = addNoteView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        newNoteBottomConstraint.isActive = true
    }
    
    
    //MARK: Add text from input to array
    
    @objc func arrowButtonTapped() {
        if addNoteView.titleTextField.text != "" {

            let note: Note = .init(isOpen: false,
                                   title: addNoteView.titleTextField.text ?? "empty",
                                   description:  addNoteView.descriptionTextField.text ?? "empty",
                                   time: addNoteView.dateTextInLabel,
                                   comment: [])

            tableView.notesArray.append(note)
            
            addNoteView.titleTextField.text = ""
            addNoteView.descriptionTextField.text = ""
//            dict = [note: []]
//            print("DICTIONARY \(dict)")
//            print(dict.count)
        } else {
            showAlert()
        }
        
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: "", message: LocalizedString.MainViewController.alertMessage, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: LocalizedString.MainViewController.alertAction, style: .default)
            alertController.addAction(alertAction)
        self.present(alertController, animated: true)
        }
    
    
    //MARK: newNoteView up with keyboard
    
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


extension UIViewController {
    
    //MARK: hide keyboard by tap Return
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: show AddCommentView on Root Controller 
    
    func showCommentView(newComment: @escaping (Comment) -> Void?) {
        var addCommentView = AddCommentView()
        view.setupViews(addCommentView)
        addCommentView.alpha = 0
        addCommentView.commentOut = { [weak self] comment in
            newComment(comment)
        }
        NSLayoutConstraint.activate([
            addCommentView.topAnchor.constraint(equalTo: view.topAnchor),
            addCommentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            addCommentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addCommentView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        if addCommentView.alpha == 0 {
            addCommentView.alpha = 1
        } else {
            addCommentView.alpha = 0
        }
    }
    
    //MARK: show Views on Root Controller (if in SceneDelegate we have UINavigationController - 1 func we dont need)
    
    func embeddedInNavigationController() -> UINavigationController {
            let navigationController = UINavigationController(rootViewController: self)
            return navigationController
        }
    
}
//show Views on Root Controller
func getRootNavigationController() -> UINavigationController? {
    return UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController as? UINavigationController ?? UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController?.navigationController
}

