//
//  UILAbel + Extancion.swift
//  NewsToDay
//
//  Created by apple on 10/23/24.
//

import UIKit

extension UILabel {
    convenience init(text: String) {
        self.init()
        self.text = text
        self.font = .boldSystemFont(ofSize: 14)
        self.textColor = .black
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.8
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    convenience init(text: String = "", font: UIFont?, textColor: UIColor) {
        self.init()
        self.text = text
        self.font  = font
        self.textColor = textColor
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
