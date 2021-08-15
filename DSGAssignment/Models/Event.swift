//
//  Event.swift
//  DSGAssignment
//
//  Created by VEER BAHADUR TIWARI on 15/08/21.
//

import Foundation

struct Events:Codable {
    let list:[Event]?
    
    /// Coding Keys for Events
    enum CodingKeys: String, CodingKey {
        case list = "events"
    }

}

struct Event:Codable {
    let type: String?
    let title:String?
    let id:Int?
    let datetime:String?
    let venue:Venue?
    let performers:[Performer]?
    
    /// Coding Keys for Event
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case title = "title"
        case id = "id"
        case datetime = "datetime_utc"
        case venue = "venue"
        case performers = "performers"
    }
    
    func isFavorites() -> Bool {
        if let id = id {
            return UserDefaultManager.shared().isInFavorites(id)
        }
        else {
            return false
        }
    }
    
    func getDateTime() -> String? {
        if let dt = datetime {
            return dt.getDateString()
        }
        else {
            return nil
        }
    }
    
    func getImageURLString() -> String  {
        if let performers = performers, let first = performers.first {
            return first.image ?? ""
        }
        else {
            return ""
        }
    }
}

struct Venue:Codable {
    let state: String?
    let name: String?
    let displayLocation:String?
    
    /// Coding Keys for Venue
    enum CodingKeys: String, CodingKey {
        case state = "state" // Raw value for enum case must be a literal
        case name = "name"
        case displayLocation = "display_location"
    }
}

struct Performer :Codable {
    let image: String?
}
