    //
    //  HomeViewModel.swift
    //  VM Directory
    //
    //  Created by Arun R Mani on 01/08/2022.
    //

import Foundation
import UIKit

enum ListType{
    case contacts
    case rooms
}

class HomeViewModel{
    
    var contactList: Observable<[People?]> = Observable([])
    var roomsList: Observable<[Rooms?]> = Observable([])
    var goTodetails: Observable<Bool> = Observable(false)
    var showError: Observable<APIError?> = Observable(nil)
    
    var selectedContact: Observable<People?> = Observable(nil)
    var selectedType: Observable<ListType?> = Observable(.contacts)
    
    var contactBgColor: Observable<UIColor?> = Observable(UIColor(named: "vm_theame_color_white"))
    var contactTitleColor: Observable<UIColor?> = Observable(UIColor(named: "vm_theame_color_textBlack"))
    
    var roomBgColor: Observable<UIColor?> = Observable(UIColor(named: "vm_theame_color_white"))
    var roomTitleColor: Observable<UIColor?> = Observable(UIColor(named: "vm_theame_color_textBlack"))
    
    var searchBarHeight: Observable<Double> = Observable(0.0)
    var searchEnable: Observable<Bool> = Observable(false)
    var searchBtnImage: Observable<UIImage?> = Observable(UIImage(named: "search_unselected"))
    var searchText: Observable<String> = Observable("")
    

     var contactListArr: [People] = []
     var roomListArr: [Rooms] = []
        
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
    
    func getContact(at index:Int) -> People?{
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
        self.searchText.value = ""
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
    
    func searchBtnPress(){
        self.searchEnable.value = !self.searchEnable.value
        self.searchBarHeight.value = self.searchEnable.value ? 75 : 0
        self.searchBtnImage.value = self.searchEnable.value ? UIImage(named: "search_selected") : UIImage(named: "search_unselected")
        if !self.searchEnable.value{
            self.searchText.value = ""
        }
        
    }
    
    func searchStringAction(str: String){
        guard self.searchEnable.value else{
            return
        }
        
        if str.count == 0{
            self.contactList.value = self.contactListArr
            self.roomsList.value = self.roomListArr
            return
        }
        switch self.selectedType.value{
            case .contacts:
                self.contactList.value = self.contactListArr.filter{ $0.firstName?.range(of: str, options: .caseInsensitive) != nil || $0.lastName?.range(of: str, options: .caseInsensitive) != nil
                }
            case .rooms:
                self.roomsList.value = self.roomListArr.filter{ $0.id?.range(of: str, options: .caseInsensitive) != nil
                }
            case .none:
                print("none")
        }

    }
}

// MARK: - Private methods


extension HomeViewModel{
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
                    self?.contactListArr = responseObj
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
                    self?.roomListArr = responseObj
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.showError.value = error
            }
        }
    }
    
}
