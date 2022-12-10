//
//  Model.swift
//  slmax-testovoe-zadanie
//
//  Created by Navi Vokavis on 2.12.22.
//

import Foundation

struct Note {
    var isOpen: Bool
    var title: String
    var description: String
    var time: String
    var comment: [String]
    
//    init(isOpen: Bool, title: String, description: String, time: String, comment: [String]) {
//        self.isOpen = isOpen
//        self.title = title
//        self.description = description
//        self.time = time
//        self.comment = comment
//    }
    
}

//var newArrayFromNotesArray: [Note] = []


struct Comment {
    var CommentTitle: String
    var CommentDescription: String
    var CommentDate: String
}

