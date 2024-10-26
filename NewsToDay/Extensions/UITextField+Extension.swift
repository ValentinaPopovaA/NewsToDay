//
//  UITextField+Extension.swift
//  NewsToDay
//
//  Created by Кирилл Бахаровский on 10/27/24.
//

import UIKit

extension UITextField {
    static func createTextField(placeholder: String,
                                fontSize: CGFloat,
                                textColor: UIColor,
                                isBold: Bool = false,
                                textAlignment: NSTextAlignment = .left,
                                borderStyle: UITextField.BorderStyle = .none,
                                keyboardType: UIKeyboardType = .default,
                                cornerRadius: CGFloat,
                                backgroundColor: CGColor? = UIColor.grayLighter!.cgColor,
                                isSecureTextEntry: Bool,
                                leftIconName: String? = nil,
                                leftIconColor: UIColor? = UIColor.grayPrimary!,
                                topPadding: CGFloat = 16,
                                leftPadding: CGFloat = 16,
                                bottomPadding: CGFloat = 16,
                                rightPadding: CGFloat = 24,
                                togglePassword: Bool = false) -> UITextField {
        
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.font = isBold ? UIFont.systemFont(ofSize: fontSize, weight: .bold) : UIFont.systemFont(ofSize: fontSize)
        textField.textColor = textColor
        textField.textAlignment = textAlignment
        textField.borderStyle = borderStyle
        textField.keyboardType = keyboardType
        textField.isSecureTextEntry = isSecureTextEntry
        textField.layer.cornerRadius = cornerRadius
        textField.layer.backgroundColor = backgroundColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        if let iconName = leftIconName, let icon = UIImage(systemName: iconName) {
            let iconView = UIImageView(image: icon)
            iconView.tintColor = leftIconColor
            iconView.contentMode = .center
            
            // Контейнер с кастомными отступами
            let paddingView = UIView(frame: CGRect(
                x: 0,
                y: 0,
                width: 24 + leftPadding + rightPadding,
                height: 24 + topPadding + bottomPadding
            ))
            
            iconView.frame = CGRect(
                x: leftPadding,
                y: topPadding,
                width: 24,
                height: 24
            )
            
            paddingView.addSubview(iconView)
            textField.leftView = paddingView
            textField.leftViewMode = .always
        }
        
        if togglePassword {
            let toggleButton = UIButton()
            toggleButton.setImage(UIImage(systemName: "eye"), for: .normal)
            toggleButton.tintColor = .gray
            toggleButton.addTarget(textField, action: #selector(textField.togglePasswordVisibility), for: .touchUpInside)
            
            textField.rightView = toggleButton
            textField.rightViewMode = .always
            
            // Контейнер с кастомными отступами
            let paddingView = UIView(frame: CGRect(
                x: 0,
                y: 0,
                width: 24 + leftPadding,
                height: 24 + topPadding + bottomPadding
            ))
            
            toggleButton.frame = CGRect(
                x: 5,
                y: topPadding,
                width: 24,
                height: 24
            )
            
            paddingView.addSubview(toggleButton)
            textField.rightView = paddingView
            textField.rightViewMode = .always
        }
        
        return textField
    }
    
    @objc private func togglePasswordVisibility() {
        isSecureTextEntry.toggle()
        let eyeIconName = isSecureTextEntry ? "eye" : "eye.slash"
        (rightView?.subviews.first as? UIButton)?.setImage(UIImage(systemName: eyeIconName), for: .normal)
    }
}
