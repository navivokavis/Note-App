//
//  Resources.swift
//  slmax-testovoe-zadanie
//
//  Created by Navi Vokavis on 2.12.22.
//

import UIKit

enum Resources {
    
    enum Colors {
        static var blackText = UIColor(hexString: "#000000")
        static var whiteText = UIColor(hexString: "#FFFFFF")
        static var separate = UIColor(hexString: "#D2D2D2")
        static var dateTextColor = UIColor(hexString: "#8F8F8F")
        static var redDeleteColor = UIColor(hexString: "#E30000")
    }
    
    enum Strings {
        static var hatString = "Заметки"
    }
    
    enum Images {
        static var hatImage = UIImage(named: "Hat")
        static var downArrow = UIImage(systemName: "chevron.down")
        static var rightArrow = UIImage(systemName: "chevron.forward")
    }
    
    enum Fonts {
        
        static func RalewayLight(with size: CGFloat) -> UIFont {
            UIFont(name: "Raleway-Light",size: size) ?? UIFont()
        }
        static func RalewaySemiBold(with size: CGFloat) -> UIFont {
            UIFont(name: "Raleway-SemiBold",size: size) ?? UIFont()
        }
    }
    
}
