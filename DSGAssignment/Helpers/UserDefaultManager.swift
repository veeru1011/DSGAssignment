//
//  UserDefaultManager.swift
//  DSGAssignment
//
//  Created by VEER BAHADUR TIWARI on 15/08/21.
//

import Foundation

class UserDefaultManager: NSObject {
    
    class func shared() -> UserDefaultManager {
        return sharedInstance
    }
    
    private static var sharedInstance: UserDefaultManager = {
        let apiManager = UserDefaultManager()
        return apiManager
    }()
    
    let userDefaults: UserDefaults
    
    private override init() {
        self.userDefaults = UserDefaults.standard
    }
    
    
    /** This function use to add `eventId` to UserDefaults.
    - Parameter eventId: This id to be saved in userDefaults .
    */
    func addToFavorited(eventId: Int) {
        
        if (userDefaults.object(forKey: UserDefaultsKeys.favorited.rawValue) != nil) {
            if var ids = userDefaults.array(forKey: UserDefaultsKeys.favorited.rawValue) as? [Int] {
                if (!ids.contains(eventId)) {
                    ids.append(eventId)
                    userDefaults.setValue(ids, forKey: UserDefaultsKeys.favorited.rawValue)
                }
            }
        }
        else {
            userDefaults.setValue([eventId], forKey: UserDefaultsKeys.favorited.rawValue)
            
        }
        userDefaults.synchronize()
    }
    
    /** This function use to remove `eventId` from UserDefaultsKeys if saved.
    - Parameter eventId: This id to be removed from userDefaults .
    */

    func removeFromFavorited(eventId: Int) {
        
        if (userDefaults.object(forKey: UserDefaultsKeys.favorited.rawValue) != nil) {
            if var ids = userDefaults.array(forKey: UserDefaultsKeys.favorited.rawValue) as? [Int] {
                if (ids.contains(eventId)) {
                    if let idx = ids.firstIndex(of: eventId) {
                        ids.remove(at: idx)
                        userDefaults.setValue(ids, forKey: UserDefaultsKeys.favorited.rawValue)
                    }
                }
            }
            userDefaults.synchronize()
        }
    }
        
    /// This function returns a boolean value  for a given `eventId`.
    ///
    /// - Parameter eventId: check for this id .
    /// - Returns: A Boolean for eventd saved or Not

    func isInFavorites(_ eventId: Int) -> Bool {
        if (userDefaults.object(forKey: UserDefaultsKeys.favorited.rawValue) != nil) {
            if let ids = userDefaults.array(forKey: UserDefaultsKeys.favorited.rawValue) as? [Int] {
                return ids.contains(eventId)
            }
        }
        return false
    }
}
