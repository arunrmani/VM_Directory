//
//  ContactDetailsViewModel.swift
//  VM Directory
//
//  Created by Safe City Mac 001 on 02/08/2022.
//

import Foundation

class ContactDetailsViewModel{
    var selectedContact: Observable<Contacts?> = Observable(nil)
    
    init(selectedContact : Contacts?){
        if let contact = selectedContact{
            self.selectedContact.value = contact
        }
    }
    
    
    
    
    
    
}
