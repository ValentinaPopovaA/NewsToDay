//
//  UILabel+Ext.swift
//  NewsToDay
//
//  Created by Валентина Попова on 22.10.2024.
//

import UIKit

extension UILabel {
    static func createLabel(text: String,
                            fontSize: CGFloat,
                            textColor: UIColor,
                            isBold: Bool = false,
                            textAlignment: NSTextAlignment = .center,
                            numberOfLines: Int = 0) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = isBold ? UIFont.interBold : UIFont.interRegular
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.numberOfLines = numberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
