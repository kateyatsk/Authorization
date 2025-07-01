//
//  SceneDelegate.swift
//  Authorization
//
//  Created by Екатерина Яцкевич on 29.06.25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        self.window?.rootViewController =  AuthViewController()
        self.window?.makeKeyAndVisible()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setRootVC), name: Notification.Name("setVC"), object: nil)

        
    }

    @objc
    func setRootVC() {
        if SaveDataManager.shared.login != "", SaveDataManager.shared.login != ""{
            self.window?.rootViewController = MainViewController()
        } else {
            self.window?.rootViewController = AuthViewController()
        }
    }

}

