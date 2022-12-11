//
//  Model.swift
//  slmax-testovoe-zadanie
//
//  Created by Navi Vokavis on 2.12.22.
//

import Foundation

struct Note: Hashable {
    var isOpen: Bool
    var title: String
    var description: String
    var time: String
    var comment: [Comment]
    
//    init(isOpen: Bool, title: String, description: String, time: String, comment: [String]) {
//        self.isOpen = isOpen
//        self.title = title
//        self.description = description
//        self.time = time
//        self.comment = comment
//    }
    
}

//var newArrayFromNotesArray: [Note] = []


struct Comment: Hashable {
    var commentTitle: String
    var commentDescription: String
    var commentDate: String
}

var commentArray2: [Comment] = []

var dict: [Note: [Comment]] = [:]
