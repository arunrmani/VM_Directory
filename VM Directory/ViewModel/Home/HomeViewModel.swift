//
//  HomeViewModel.swift
//  VM Directory
//
//  Created by Safe City Mac 001 on 01/08/2022.
//

import Foundation


class HomeViewModel{
    
    var contactList: Observable<[Contacts?]> = Observable([])
    var roomsList: Observable<[Rooms?]> = Observable([])
    var goTodetails: Observable<Bool> = Observable(false)
    
    var selectedContact: Observable<Contacts?> = Observable(nil)

    var contactListCount: Int  {
        get{
            return self.contactList.value.count
        }
    }
    var roomsListCount: Int  {
        get{
            return self.roomsList.value.count
        }
    }
    
    func getContact(at index:Int) -> Contacts?{
        guard contactListCount > 0 else{
            return nil
        }
        if let contact = self.contactList.value[index]{
            return contact
        }
        return nil
    }
    func getRoom(at index:Int) -> Rooms?{
        guard roomsListCount > 0 else{
            return nil
        }
        if let contact = self.roomsList.value[index]{
            return contact
        }
        return nil
    }
    
    func selectContact(index: Int){
        if let sContact = self.getContact(at: index){
            self.selectedContact.value = sContact
            self.goTodetails.value = true
        }
    }
}


// MARK: - API Call

extension HomeViewModel{
    func getContactListAPI(){
        
    }
}
