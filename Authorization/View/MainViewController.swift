//
//  MainView.swift
//  Authorization
//
//  Created by Екатерина Яцкевич on 1.07.25.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    private let storage = StorageManager()
    
    lazy var mainLabel: UILabel = {
        $0.text = "Главный экран"
        $0.font = .systemFont(ofSize: 28, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    lazy var welcomeLabel: UILabel = {
        $0.text = "Добрый день"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    lazy var nameLabel: UILabel = {
        $0.text = SaveDataManager.shared.login
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    lazy var textLabel: UILabel = {
        $0.text = "Ваш пароль:"
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    lazy var passwordLabel: UILabel = {
        $0.text = SaveDataManager.shared.password
        $0.font = .systemFont(ofSize: 10, weight: .medium)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        return picker
    }()
    
    
    lazy var uploadPhotoButton: UIButton = {
        $0.setTitle("Загрузить фото", for: .normal)
        $0.tintColor = .lightGray
        $0.backgroundColor = .black
        $0.layer.cornerRadius = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(primaryAction: UIAction(handler: { [weak self] _ in
        guard let self else { return }
        self.present(self.imagePicker, animated: true)
    })))
    
    lazy var logoutButton: UIButton = {
        $0.setTitle("Выйти", for: .normal)
        $0.tintColor = .lightGray
        $0.backgroundColor = .black
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    lazy var imageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 12
        return $0
    }(UIImageView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubviews(
            mainLabel,
            welcomeLabel,
            nameLabel,
            textLabel,
            passwordLabel,
            uploadPhotoButton,
            logoutButton,
            imageView
        )
        setup()
        
        if let imageData = storage.getImage(name: "myPhoto"),
           let image = UIImage(data: imageData) {
            imageView.image = image
        }
        
    }
    
    func setup() {
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            welcomeLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 40),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            nameLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            textLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 40),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            passwordLabel.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 10),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            uploadPhotoButton.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 20),
            uploadPhotoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            uploadPhotoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            uploadPhotoButton.heightAnchor.constraint(equalToConstant: 40),
            
            imageView.topAnchor.constraint(equalTo: uploadPhotoButton.bottomAnchor, constant: 60),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            logoutButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        uploadPhotoButton.addTarget(self, action: #selector(uploadPhoto), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
    
    
    @objc
    private func logout() {
        SaveDataManager.shared.clearUserData()
        NotificationCenter.default.post(name: Notification.Name("setVC"), object: nil)
    }
    
    @objc
    private func uploadPhoto() {
        present(imagePicker, animated: true)
    }
}

extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true)
        
        if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            if let imageData = image.jpegData(compressionQuality: 0.9) {
                storage.saveImage(image: imageData, name: "myPhoto")
                imageView.image = image
            }
        }
    }
}
