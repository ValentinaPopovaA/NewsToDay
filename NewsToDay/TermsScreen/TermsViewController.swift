//
//  TermsAndConditionsViewController.swift
//  NewsToDay
//
//  Created by Валентина Попова on 22.10.2024.
//

import UIKit

class TermsViewController: UIViewController {
    
    private lazy var termsTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.attributedText = getTermsAndConditionsText()
        textView.textAlignment = .justified
        textView.textColor = UIColor.grayDark
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Terms & Conditions"
        view.backgroundColor = .white
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(termsTextView)
        
        NSLayoutConstraint.activate([
            termsTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            termsTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            termsTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            termsTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func getTermsAndConditionsText() -> NSAttributedString {
        let attributedText = NSMutableAttributedString()
        
        let introAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.interRegular ?? UIFont.systemFont(ofSize: 16)
        ]
        let introText = NSAttributedString(string: """
        Welcome to our News To Day App. Please read these terms and conditions carefully before using our service.\n\n
        """, attributes: introAttributes)
        attributedText.append(introText)

        
        let sections: [(String, String)] = [
            ("1. Acceptance of Terms", "By accessing or using the News App, you agree to be bound by these Terms & Conditions. If you do not agree to any part of these terms, please do not use our service."),
            ("2. Service Description", "Our app provides you with access to news articles and information from various sources. The content is for general information purposes only and may change without notice."),
            ("3. User Conduct", "You agree to use the app only for lawful purposes. You must not:\n- Engage in any activity that disrupts the functionality of the app.\n- Copy, distribute, or modify any content from the app without proper authorization."),
            ("4. Intellectual Property", "All content available through the app, including text, graphics, logos, and software, is owned by us or our licensors. You may not reproduce, republish, or distribute this content without our permission."),
            ("5. Third-Party Content", "Our app may display links to third-party websites or content. We are not responsible for the accuracy, legality, or availability of such content and are not liable for any damages or losses that arise from using them."),
            ("6. Disclaimer of Warranties", "We do not guarantee the accuracy, completeness, or timeliness of the information provided. The app and its content are provided 'as is,' without any warranties."),
            ("7. Limitation of Liability", "In no event shall we be liable for any direct, indirect, or consequential damages resulting from the use or inability to use the app."),
            ("8. Changes to Terms", "We may update these Terms & Conditions from time to time. Continued use of the app after any changes means you accept the updated terms."),
            ("9. Contact Us", "If you have any questions about these Terms & Conditions, please contact us at Devrush marathon.")
        ]
        
        for section in sections {
            let titleAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.interSemibold ?? UIFont.boldSystemFont(ofSize: 18)
            ]
            let bodyAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.interRegular ?? UIFont.systemFont(ofSize: 16)
            ]
            
            let titleString = NSAttributedString(string: "\(section.0)\n\n", attributes: titleAttributes)
            let bodyString = NSAttributedString(string: "\(section.1)\n\n", attributes: bodyAttributes)
            
            attributedText.append(titleString)
            attributedText.append(bodyString)
        }
        
        return attributedText
    }
}
