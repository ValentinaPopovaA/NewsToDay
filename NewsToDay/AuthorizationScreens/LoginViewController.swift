//
//  LoginViewController.swift
//  NewsToDay
//
//  Created by Кирилл Бахаровский on 10/27/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    private lazy var titleLabel = UILabel.createLabel(
        text: "Welcome Back 👋",
        fontSize: 24,
        textColor: .blackPrimary!,
        isBold: true,
        textAlignment: .left)
    
    private lazy var subTitle = UILabel.createLabel(
        text: "I am happy to see you again. You can continue where you left off by logging in",
        fontSize: 16,
        textColor: .grayPrimary!,
        textAlignment: .left)
    
    private lazy var emailTF = UITextField.createTextField(
        placeholder: "Email Address",
        fontSize: 16,
        textColor: .grayPrimary!,
        cornerRadius: 12,
        isSecureTextEntry: false,
        leftIconName: "envelope",
        IconColor: .grayPrimary!,
        leftPadding: 24)
    
    private lazy var passwordTF = UITextField.createTextField(
        placeholder: "Password",
        fontSize: 16,
        textColor: .grayPrimary!,
        cornerRadius: 12,
        isSecureTextEntry: true,
        leftIconName: "lock",
        IconColor: .grayPrimary!,
        leftPadding: 24,
        togglePassword: true)
    
    private lazy var signUpLabel = UILabel.createLabel(
        text: "Don't have an account?",
        fontSize: 16,
        textColor: .blackLighter!,
        textAlignment: .center)
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.blackPrimary!, for: .normal)
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var signUpStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var loginButton = UIButton().makeButtonwithLabel(label: "Sign In", buttonColor: .purplePrimary, textColor: .white, target: self, action: #selector(loginButtonTapped))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
        setConstraints()
        hideKeyboardWhenTappedAround()
    }
    
    
    @objc func loginButtonTapped() {
        print("loginButtonTapped")
    }
    
    @objc func signUpButtonTapped() {
        let vc = RegisterViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
}
// MARK: - KeyBoard
extension LoginViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension LoginViewController {
    
    private func setupViews() {
        [signUpLabel, signUpButton].forEach { localView in
            signUpStackView.addArrangedSubview(localView)
        }
        
        [titleLabel, subTitle, emailTF, passwordTF, loginButton, signUpStackView].forEach { localView in
            localView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(localView)
        }
        
        [emailTF, passwordTF].forEach { textField in
            textField.addTarget(self, action: #selector(changeTextFieldBackground), for: .allEditingEvents)
        }
    }
    
    @objc private func changeTextFieldBackground(sender: UITextField) {
        sender.backgroundColor = .white
        sender.textColor = .black
        
        let borderLayer = CALayer()
        borderLayer.frame = sender.bounds
        borderLayer.borderColor = UIColor.purplePrimary?.cgColor
        borderLayer.borderWidth = 1.0
        borderLayer.cornerRadius = 12
        borderLayer.masksToBounds = true
        sender.rightView?.subviews.first?.tintColor = .white
        
        sender.layer.insertSublayer(borderLayer, at: 0)
        sender.leftView?.subviews.first?.tintColor = .purplePrimary
        
        guard let textCount = sender.text?.count else { return }
        if textCount >= 1 {
            sender.rightView?.subviews.first?.tintColor = .purplePrimary
        } else {
            
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            subTitle.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            subTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            subTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            emailTF.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 32),
            emailTF.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emailTF.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            emailTF.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        NSLayoutConstraint.activate([
            passwordTF.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 16),
            passwordTF.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            passwordTF.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            passwordTF.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 64),
            loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        NSLayoutConstraint.activate([
            signUpStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
        ])
    }
}
