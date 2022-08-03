//
//  Rooms.swift
//  VM Directory
//
//  Created by Safe City Mac 001 on 02/08/2022.
//

import Foundation
import UIKit

struct Rooms: Codable{
    var createdAt: String?
    var isOccupied: Bool?
    var maxOccupancy: Int?
    var id: String?
    
    func getDate() -> String{
        return (self.createdAt ?? "").toString(dateFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    }
    
    func getImageAvailability() -> UIImage{
        return isOccupied ?? false ?  UIImage(named: "room_sample_unavailable")! :  UIImage(named: "room_sample_available")!
    }
}
