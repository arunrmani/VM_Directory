    //
    //  HomeViewModel.swift
    //  VM Directory
    //
    //  Created by Safe City Mac 001 on 01/08/2022.
    //

import Foundation
import UIKit

enum ListType{
    case contacts
    case rooms
}

class HomeViewModel{
    
    var contactList: Observable<[Contacts?]> = Observable([])
    var roomsList: Observable<[Rooms?]> = Observable([])
    var goTodetails: Observable<Bool> = Observable(false)
    var showError: Observable<APIError?> = Observable(nil)
    
    var selectedContact: Observable<Contacts?> = Observable(nil)
    var selectedType: Observable<ListType?> = Observable(.contacts)
    
    var contactBgColor: Observable<UIColor?> = Observable(UIColor(named: "vm_theame_color_white"))
    var contactTitleColor: Observable<UIColor?> = Observable(UIColor(named: "vm_theame_color_textBlack"))
    
    var roomBgColor: Observable<UIColor?> = Observable(UIColor(named: "vm_theame_color_white"))
    var roomTitleColor: Observable<UIColor?> = Observable(UIColor(named: "vm_theame_color_textBlack"))
    
    
    
    

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
    
    func selectListType(type: ListType){
        self.selectedType.value = type
        self.updateSelectionType(type: type)
        switch self.selectedType.value{
            case .contacts:
                self.getContactListAPI()
            case .rooms:
                self.getRoomListAPI()
            case .none:
                print("none")
        }
    }
    
    
    private func updateSelectionType(type: ListType){
        self.contactBgColor.value = UIColor(named: "vm_theame_color_white")
        self.contactTitleColor.value = UIColor(named: "vm_theame_color_textBlack")
        self.roomBgColor.value = UIColor(named: "vm_theame_color_white")
        self.roomTitleColor.value = UIColor(named: "vm_theame_color_textBlack")
        
        switch type {
            case .contacts:
                self.contactBgColor.value = UIColor(named: "vm_theame_color_gray")
                self.contactTitleColor.value = UIColor(named: "vm_theame_color_white")
            case .rooms:
                self.roomBgColor.value = UIColor(named: "vm_theame_color_gray")
                self.roomTitleColor.value = UIColor(named: "vm_theame_color_white")
        }
    }
   
    
}


    // MARK: - API Call

extension HomeViewModel{
    func getContactListAPI(){
        ARMLoader.show()
        APIClient.shared.getPeopleList {[weak self] result in
            ARMLoader.hide()
            switch result{
                case .success(let responseObj):
                    self?.contactList.value = responseObj
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.showError.value = error
            }
        }
    }
    
    func getRoomListAPI(){
        ARMLoader.show()
        APIClient.shared.getRoomList {[weak self] result in
            ARMLoader.hide()
            switch result{
                case .success(let responseObj):
                    self?.roomsList.value = responseObj
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.showError.value = error
            }
        }
    }
    
}
