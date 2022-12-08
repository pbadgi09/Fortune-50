//
//  Preferences.swift
//  Fortune 50
//
//  Created by Pranav Badgi on 12/7/22.
//

import Foundation

enum SortBy: String {
    case byCompanyName
    case bySymbol
}


final class Preferences {
    
    //MARK: - Properties
    static let shared = Preferences()
    
    private let defaults = UserDefaults.standard
    
    
    //MARK: - Init
    private init() {}
    
    
    //MARK: - Getter / Setters
    
    func sortMethodExists() -> Bool {
        if defaults.object(forKey: "sortBy") != nil {
            return true
        } else {
            return false
        }
    }
    
    func setSortMethod(_ method: SortBy) {
        if sortMethodExists() {
            defaults.set(method.rawValue, forKey: "sortBy")
        } else {
            defaults.set(SortBy.byCompanyName.rawValue, forKey: "sortBy")
        }
    }
    
    
    func currentSortingMethod() -> SortBy {
        if sortMethodExists() {
            let method = defaults.string(forKey: "sortBy")
            if method == "byCompanyName" {
                return .byCompanyName
            } else {
                return .bySymbol
            }
        } else {
            return .byCompanyName
        }
    }
    
    
}
