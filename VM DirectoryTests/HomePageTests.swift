//
//  HomePageTests.swift
//  VM DirectoryTests
//
//  Created by Safe City Mac 001 on 02/08/2022.
//

import XCTest
@testable import VM_Directory

class HomePageTests: XCTestCase {

    func test_LoginViewIsLoaded() throws{
        _ = try makeSUT()
    }
    
    func test_ViewDidLoad_configurationTableView() throws{
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.tableView.delegate,"TableView deligate is nil")
        XCTAssertNotNil(sut.tableView.dataSource,"TableView dataSourse is nil")
    }
    
    func test_ViewModelInitialState(){
        let vm = HomeViewModel()
        
        XCTAssertFalse(vm.goTodetails.value)
        XCTAssertEqual(vm.contactListCount, 0)
        XCTAssertEqual(vm.roomsListCount, 0)
        XCTAssertNil(vm.selectedContact.value)
        XCTAssertNil(vm.getContact(at:0))
        XCTAssertNil(vm.getRoom(at:0))

    }
    
    func test_getContactAtindex() {
        let vm = HomeViewModel()
        
        XCTAssertNil(vm.getContact(at:0))
        XCTAssertNil(vm.getRoom(at:0))
        vm.selectContact(index: 0)
        XCTAssertNil(vm.selectedContact.value)

        let sampleList = self.getSampleContactList()
        vm.contactList.value = sampleList
        
        XCTAssertNotNil(vm.getContact(at:0))
        vm.selectContact(index: 0)
        XCTAssertNotNil(vm.selectedContact.value)
        
        
        let sampleRoom = self.getSampleRoomList()
        vm.roomsList.value = sampleRoom
        XCTAssertNotNil(vm.getRoom(at:0))

        
    }
    
    func test_getContactListAPI(){
        
        let vm = HomeViewModel()
        XCTAssertEqual(vm.contactListCount, 0)
        vm.getContactListAPI()
        let exp = expectation(description: "Waiting for API respose(Get People list)")
        exp.isInverted = true
        wait(for: [exp], timeout: 10)
        
        XCTAssertGreaterThan(vm.contactListCount, 0)

        
    }
    
    func test_selectType() throws{
        let vm = HomeViewModel()
        vm.selectListType(type: .rooms)
        XCTAssertEqual(vm.selectedType.value, .rooms)
        vm.selectListType(type: .contacts)
        XCTAssertEqual(vm.selectedType.value, .contacts)
        XCTAssertEqual(vm.contactBgColor.value, UIColor(named: "vm_theame_color_gray"))
        XCTAssertEqual(vm.roomBgColor.value, UIColor(named: "vm_theame_color_white"))
        
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        let btn = UIButton()
        sut.roomBtnPress(btn)
        
        XCTAssertEqual(sut.homeVM.roomBgColor.value, UIColor(named: "vm_theame_color_gray"))
        XCTAssertEqual(sut.homeVM.contactBgColor.value, UIColor(named: "vm_theame_color_white"))
        XCTAssertEqual(sut.homeVM.selectedType.value, .rooms)

    }
        
    func test_getRoomListAPI(){
        
        let vm = HomeViewModel()
        XCTAssertEqual(vm.roomsListCount, 0)
        vm.getRoomListAPI()
        let exp = expectation(description: "Waiting for API respose(Get Room list)")
        exp.isInverted = true
        wait(for: [exp], timeout: 10)
        XCTAssertGreaterThan(vm.roomsListCount, 0)
        
    }
    
    
    
}

extension HomePageTests{
    private func makeSUT()throws -> HomeViewController{
        let bundle = Bundle(for: HomeViewController.self)
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        if #available(iOS 13.0, *) {
            let homeVC = sb.instantiateViewController(identifier: "HomeViewController")
            return try XCTUnwrap(homeVC as? HomeViewController)
        } else {
                // Fallback on earlier versions
            let homeVC =  sb.instantiateViewController(withIdentifier: "HomeViewController")
            return try XCTUnwrap(homeVC as? HomeViewController)

        }
    }
    
    
    private func getSampleContactList() -> [Contacts]{
        let contact1 = Contacts(createdAt: "2022-01-24T17:02:23.729Z", firstName: "Maggie", avatar: "https://randomuser.me/api/portraits/women/21.jpg", lastName: "Brekke", email: "Crystel.Nicolas61@hotmail.com", jobtitle: "Future Functionality Strategist", favouriteColor: "pink", id: "1")
        let contact2 = Contacts(createdAt: "2022-01-24T17:02:23.729Z", firstName: "Armando", avatar: "https://randomuser.me/api/portraits/women/21.jpg", lastName: "Weber", email: "Milton.Wisoky@gmail.com", jobtitle: "Principal Accounts Developer", favouriteColor: "pink", id: "2")
        let contact3 = Contacts(createdAt: "2022-01-24T17:02:23.729Z", firstName: "Ceasar", avatar: "https://randomuser.me/api/portraits/women/21.jpg", lastName: "Turner", email: "Crystel.Nicolas61@hotmail.com", jobtitle: "Future Interactions Supervisor", favouriteColor: "pink", id: "3")
        
        
        return [contact1,contact2,contact3]
        
    }
    
    private func getSampleRoomList() -> [Rooms]{
        let room1 = Rooms(createdAt: "2022-01-24T17:02:23.729Z", isOccupied: true, maxOccupancy: 5555, id: "1")
        let room2 = Rooms(createdAt: "2022-01-24T17:02:23.729Z", isOccupied: true, maxOccupancy: 5555, id: "2")
        let room3 = Rooms(createdAt: "2022-01-24T17:02:23.729Z", isOccupied: true, maxOccupancy: 5555, id: "3")
        let room4 = Rooms(createdAt: "2022-01-24T17:02:23.729Z", isOccupied: true, maxOccupancy: 5555, id: "4")
        return [room1,room2,room3,room4]
    }
    
}
