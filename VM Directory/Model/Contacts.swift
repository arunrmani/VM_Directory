//
//  Contacts.swift
//  VM Directory
//
//  Created by Safe City Mac 001 on 02/08/2022.
//

import Foundation


struct Contacts: Codable{
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
