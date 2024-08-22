//
//  UserStorage.swift
//  WallpaperApp
//
//  Created by Şükrü on 21.08.2024.
//

import Foundation

/// `Storage` is a property wrapper that simplifies storing and retrieving Codable objects in UserDefaults.
/// It automatically encodes the value to Data when saving, and decodes it when retrieving.
///
/// ### Usage Example:
/// ```
/// @Storage(key: "userSettings", defaultValue: UserSettings())
/// var userSettings: UserSettings
///
/// // This will save the userSettings to UserDefaults
/// userSettings = newUserSettings
///
/// // This will retrieve the userSettings from UserDefaults, or return the default value if not found
/// let currentSettings = userSettings
/// ```
///
/// - Note: The wrapped type `T` must conform to `Codable`.

// MARK: - UserStorage
@propertyWrapper
struct UserStorage<T: Codable> {
    
    // MARK: - Variables
    private let key: String
    private let defaultValue: T
    
    // MARK: - Initialize
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    // MARK: - Wrapped Value
    var wrappedValue: T {
        get {
            // Retrieve the data from UserDefaults, return defaultValue if not found
            guard let data = UserDefaults.standard.data(forKey: key) else {
                return defaultValue
            }
            
            // Try to decode the data, return defaultValue if decoding fails
            if let decodedValue = try? JSONDecoder().decode(T.self, from: data) {
                return decodedValue
            } else {
                return defaultValue
            }
        }
        set {
            // Try to encode the new value and save it to UserDefaults
            if let encodedData = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encodedData, forKey: key)
            }
        }
    }
}
