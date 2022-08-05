//
//  Contacts.swift
//  VM Directory
//
//  Created by Arun R Mani on 02/08/2022.
//

import Foundation


struct People: Codable{
    var createdAt: String?
    var firstName: String?
    var avatar: String?
    var lastName: String?
    var email: String?
    var jobtitle: String?
    var favouriteColor: String?
    var id: String?
    
    func getFullName() -> String{
        let firstname = self.firstName ?? ""
        let lastname = self.lastName ?? ""
        
        return firstname + " " + lastname

    }
}
