////
////  AMPLocalizeUtils.swift
////  slmax-testovoe-zadanie
////
////  Created by Navi Vokavis on 8.12.22.
////
//
//import Foundation
//
//class AMPLocalizeUtils: NSObject {
//
//    static let defaultLocalizer = AMPLocalizeUtils()
//    var appbundle = Bundle.main
//    
//    func setSelectedLanguage(lang: String) {
//        guard let langPath = Bundle.main.path(forResource: lang, ofType: "lproj") else {
//            appbundle = Bundle.main
//            return
//        }
//        appbundle = Bundle(path: langPath)!
//    }
//    
//    func stringForKey(key: String) -> String {
//        return appbundle.localizedString(forKey: key, value: "", table: nil)
//    }
//}
