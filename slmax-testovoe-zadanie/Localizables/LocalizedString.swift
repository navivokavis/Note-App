//
//  LocalizedString.swift
//  slmax-testovoe-zadanie
//
//  Created by Navi Vokavis on 8.12.22.
//

import Foundation

import UIKit

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
}

class LocalizedString {
    
    struct NavBar {
        static var hatString: String{"hatString".localized()}
    }
    
    struct MainViewController {
        static var alertMessage: String{"alertMessage".localized()}
        static var alertAction: String{"alertAction".localized()}
    }
    
    struct MainNoteView {
        static var deleteButton: String{"deleteButton".localized()}
    }
    
    struct AddNoteView {
        static var titleInput: String{"titleInput".localized()}
        static var descriptionInput: String{"descriptionInput".localized()}
    }
    
    struct AddCommentView {
        static var titleTextLabel: String{"titleTextLabel".localized()}
        static var commentTitleTextField: String{"commentTitleTextField".localized()}
        static var commentDescriptionTextView: String{"commentDescriptionTextView".localized()}

    }
    
}
