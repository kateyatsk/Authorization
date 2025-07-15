//
//  StorageManager.swift
//  Authorization
//
//  Created by Екатерина Яцкевич on 8.07.25.
//

import UIKit

class StorageManager {
    private let fileManager = FileManager.default
    
    private var directoryURL: URL {
        fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    func saveImage(image: Data, name: String) {
        let url = directoryURL.appendingPathComponent("\(name).jpg")
        try? image.write(to: url)
    }

    func getImage(name: String) -> Data? {
        let url = directoryURL.appendingPathComponent("\(name).jpg")
        return try? Data(contentsOf: url)
    }

    func removeImage(name: String) {
        let url = directoryURL.appendingPathComponent("\(name).jpg")
        try? fileManager.removeItem(at: url)
    }
}
