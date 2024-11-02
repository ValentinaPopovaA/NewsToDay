//
//  RegisterViewController.swift
//
//  NewsToDay
//
//  Created by Кирилл Бахаровский on 10/27/24.
//

import UIKit

class RegisterViewController: UIViewController {
    
    enum RegistrationError: Error {
        case passwordsMismatch
        case emptyUsername
        case emptyEmail
        case emptyPassword
        case emptyPasswordRepeat
        case invalidEmail
    }
    
    private lazy var titleLabel = UILabel.createLabel(
        text: "Welcome to NewsToDay",
        fontSize: 24,
        textColor: .blackPrimary!,
        isBold: true,
        textAlignment: .left)
    
    private lazy var subTitle = UILabel.createLabel(
        text: "Hello, I guess you are new around here. You can start using the application after sign up.",
        fontSize: 16,
        textColor: .grayPrimary!,
        textAlignment: .left)
    
    private lazy var usernameTF = UITextField.createTextField(
        placeholder: "Username",
        fontSize: 16,
        textColor: .grayPrimary!,
        cornerRadius: 12,
        isSecureTextEntry: false,
        leftIconName: "person",
        IconColor: .grayPrimary!,
        leftPadding: 24)
    
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
    
    private lazy var passwordRepeatTF = UITextField.createTextField(
        placeholder: "Repeat password",
        fontSize: 16,
        textColor: .grayPrimary!,
        cornerRadius: 12,
        isSecureTextEntry: true,
        leftIconName: "lock",
        IconColor: .grayPrimary!,
        leftPadding: 24,
        togglePassword: true)
    
    private lazy var signUpLabel = UILabel.createLabel(
        text: "Already have an account?",
        fontSize: 16,
        textColor: .blackLighter!,
        textAlignment: .center)
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.blackPrimary!, for: .normal)
        button.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var signUpStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var loginButton = UIButton().makeButtonwithLabel(label: "Sign Up", buttonColor: .purplePrimary, textColor: .white, fontSize: 16, target: self, action: #selector(loginButtonTapped))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
        setConstraints()
        hideKeyboardWhenTappedAround()
    }
    
    
    @objc func loginButtonTapped() {
        
        // Проверка на правильность ввода данных
        switch validateInputs() {
        case .success:
            register(email: emailTF.text!, password: passwordTF.text!, username: usernameTF.text!)
            
        case .failure(let error):
            switch error {
            case .passwordsMismatch:
                AlertService.shared.showAlert(title: "Ошибка", message: "Пароли не совпадают", on: self)
            case .emptyUsername:
                AlertService.shared.showAlert(title: "Ошибка", message: "Имя пользователя не должно быть пустым", on: self)
            case .emptyEmail:
                AlertService.shared.showAlert(title: "Ошибка", message: "Email не должен быть пустым", on: self)
            case .invalidEmail:
                AlertService.shared.showAlert(title: "Ошибка", message: "Введите корректный адрес электронной почты", on: self)
            case .emptyPassword:
                AlertService.shared.showAlert(title: "Ошибка", message: "Пароль не должен быть пустым", on: self)
            case .emptyPasswordRepeat:
                AlertService.shared.showAlert(title: "Ошибка", message: "Повтор пароля не должен быть пустым", on: self)
            }
        }
    }
    
    
    private func register(email: String, password: String, username: String) {
        AuthService.shared.register(email: email, password: password, username: username) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let authDataResult):
                print("Пользователь зарегистрирован", authDataResult.user.uid)
                AlertService.shared.showAlert(title: "Регистрация успешна", message: "Пожалуйста, авторизуйтесь", on: self) {
                    AuthService.shared.signOut { result in
                        switch result {
                        case .success():
                            print("Зарегистрирован и ожидаем авторизацию")
                        case .failure(let error):
                            print("Зарегистрирован, но что-то пошло не так - \(error.localizedDescription)")
                        }
                    }
                    self.navigateToLogin()
                }
            case .failure(let error):
                AlertService.shared.showError(error, on: self)
            }
        }
    }
    
    @objc func signInButtonTapped() {
        navigateToLogin()
    }
    
    private func navigateToLogin() {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}

// MARK: - Валидность полей ввода
extension RegisterViewController {
    private func validateInputs() -> Result<Void, RegistrationError> {
        guard let username = usernameTF.text, !username.isEmpty else {
            return .failure(.emptyUsername)
        }
        guard let email = emailTF.text, !email.isEmpty else {
            return .failure(.emptyEmail)
        }
        
        guard isValidEmail(email) else {
                return .failure(.invalidEmail)
            }
        
        guard let password = passwordTF.text, !password.isEmpty else {
            return .failure(.emptyPassword)
        }
        guard let passwordRepeat = passwordRepeatTF.text, !passwordRepeat.isEmpty else {
            return .failure(.emptyPasswordRepeat)
        }
        
        if password != passwordRepeat {
            return .failure(.passwordsMismatch)
        }
        
        return .success(())
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

// MARK: - KeyBoard
extension RegisterViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension RegisterViewController {
    
    private func setupViews() {
        [signUpLabel, signUpButton].forEach { localView in
            signUpStackView.addArrangedSubview(localView)
            
        }
        
        [titleLabel, subTitle, usernameTF, emailTF, passwordTF, passwordRepeatTF, loginButton, signUpStackView].forEach { localView in
            localView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(localView)
        }
        
        [usernameTF, emailTF, passwordTF, passwordRepeatTF].forEach { textField in
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
        sender.textContentType = .oneTimeCode
        
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
            usernameTF.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 32),
            usernameTF.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            usernameTF.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            usernameTF.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        NSLayoutConstraint.activate([
            emailTF.topAnchor.constraint(equalTo: usernameTF.bottomAnchor, constant: 16),
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
            passwordRepeatTF.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 16),
            passwordRepeatTF.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            passwordRepeatTF.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            passwordRepeatTF.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordRepeatTF.bottomAnchor, constant: 16),
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

