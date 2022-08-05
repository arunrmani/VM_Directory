//
//  ContactDetailsViewModel.swift
//  VM Directory
//
//  Created by Arun R Mani on 02/08/2022.
//

import Foundation

class ContactDetailsViewModel{
    var selectedContact: Observable<People?> = Observable(nil)
    init(selectedContact : People?){
        if let contact = selectedContact{
            self.selectedContact.value = contact
        }
    }
}
