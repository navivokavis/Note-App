//
//  Resources.swift
//  slmax-testovoe-zadanie
//
//  Created by Navi Vokavis on 2.12.22.
//

import UIKit

enum Resources {
    
    enum Colors {
        static var whiteBackground = UIColor(hexString: "#FFFFFF")
        static var blackBackground = UIColor(hexString: "#000000")
        static var whiteText = UIColor(hexString: "#FFFFFF")
        static var blackText = UIColor(hexString: "#000000")
        static var separate = UIColor(hexString: "#D2D2D2")
        static var dateTextColor = UIColor(hexString: "#8F8F8F")
        static var redDeleteColor = UIColor(hexString: "#E30000")
        static var violetBright = UIColor(hexString: "#7363D1")
        static var greenDark = UIColor(hexString: "#10637D")
        static var addCommentGray = UIColor(hexString: "#717171")
    }
    
    enum Images {
        static var hatImage = UIImage(named: "Hat")
        static var downArrow = UIImage(systemName: "chevron.down")
        static var rightArrow = UIImage(systemName: "chevron.forward")
        static var moon = UIImage(systemName: "moon.circle")
        static var sun = UIImage(systemName: "sun.min")
        static var plus = UIImage(systemName: "plus.bubble.fill")
        static var checkmarkMessage = UIImage(systemName: "checkmark.message.fill")
        static var paperplaneFill = UIImage(systemName: "paperplane.fill")
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
