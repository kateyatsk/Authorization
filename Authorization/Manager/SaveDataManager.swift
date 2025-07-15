//
//  SaveDataManager.swift
//  Authorization
//
//  Created by Екатерина Яцкевич on 1.07.25.
//

import Foundation

class SaveDataManager {
    private init() {}
    static let shared = SaveDataManager()
    
    private let defaults = UserDefaults.standard
    
    var login: String {
        get { defaults.string(forKey: "login") ?? "" }
        set { defaults.set(newValue, forKey: "login") }
    }
    
    var password: String {
        get { defaults.string(forKey: "password") ?? "" }
        set { defaults.set(newValue, forKey: "password") }
    }
    
    var isAuthorized: Bool {
        !login.isEmpty && !password.isEmpty
    }
    
    func clearUserData() {
        login = ""
        password = ""
    }
    
}
