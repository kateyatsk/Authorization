//
//  ViewController.swift
//  Authorization
//
//  Created by Екатерина Яцкевич on 29.06.25.
//

import UIKit

class AuthViewController: UIViewController {

    lazy var authLabel: UILabel = {
        $0.text = "Авторизация"
        $0.font = .systemFont(ofSize: 28, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    lazy var nameField: UITextField = {
        $0.placeholder = "Введите имя"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemGray2
        $0.textColor = .systemGray6
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 21, height: 0))
        $0.leftViewMode = .always
        $0.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 21, height: 0))
        $0.rightViewMode = .always
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        return $0
    }(UITextField())
    
    lazy var passwordField: UITextField = {
        $0.placeholder = "Введите пароль"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isSecureTextEntry = true
        $0.backgroundColor = .systemGray2
        $0.textColor = .systemGray6
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 21, height: 0))
        $0.leftViewMode = .always
        $0.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 21, height: 0))
        $0.rightViewMode = .always
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        return $0
    }(UITextField())
    
    lazy var loginButton: UIButton = {
        $0.setTitle("Войти", for: .normal)
        $0.tintColor = .lightGray
        $0.backgroundColor = .black
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubviews(authLabel, nameField, passwordField, loginButton)
        setup()
    }
    
    func setup() {
        NSLayoutConstraint.activate([
            authLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            authLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            authLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            nameField.topAnchor.constraint(equalTo: authLabel.bottomAnchor, constant: 70),
            nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameField.heightAnchor.constraint(equalToConstant: 35),
            
            passwordField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 10),
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordField.heightAnchor.constraint(equalToConstant: 35),
            
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }

    @objc
    private func login() {
        SaveDataManager.shared.login = self.nameField.text ?? ""
        SaveDataManager.shared.password = self.passwordField.text ?? ""
        NotificationCenter.default.post(name: Notification.Name("setVC"), object: nil)
    }
    
}

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach({addSubview($0)})
    }
}
