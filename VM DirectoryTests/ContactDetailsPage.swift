    //
    //  ContactDetailsPage.swift
    //  VM DirectoryTests
    //
    //  Created by Safe City Mac 001 on 04/08/2022.
    //

import XCTest
@testable import VM_Directory

class ContactDetailsPageTests: XCTestCase {
    
    func test_detsilsViewIsLoaded() throws{
        _ = try makeSUT()
    }
    
    func test_dataSetUp() throws{
        let sut = try makeSUT()
        sut.loadViewIfNeeded()

        let contact = Contacts(createdAt: "2022-01-24T17:02:23.729Z", firstName: "Maggie", avatar: "https://randomuser.me/api/portraits/women/21.jpg", lastName: "Brekke", email: "Crystel.Nicolas61@hotmail.com", jobtitle: "Future Functionality Strategist", favouriteColor: "pink", id: "1")
        sut.detailsVM = ContactDetailsViewModel(selectedContact: contact)
        sut.viewDidLoad()
        
        XCTAssertNotNil(sut.detailsVM)

        XCTAssertEqual(sut.detailsVM?.selectedContact.value?.firstName, contact.firstName)
        XCTAssertEqual(sut.detailsVM?.selectedContact.value?.lastName, contact.lastName)
        XCTAssertEqual(sut.detailsVM?.selectedContact.value?.jobtitle, contact.jobtitle)
        XCTAssertEqual(sut.detailsVM?.selectedContact.value?.email, contact.email)
        XCTAssertEqual(sut.detailsVM?.selectedContact.value?.favouriteColor, contact.favouriteColor)
        
    }
}


extension ContactDetailsPageTests{
    private func makeSUT()throws -> ContactDetailsViewController{
        let bundle = Bundle(for: ContactDetailsViewController.self)
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        if #available(iOS 13.0, *) {
            let homeVC = sb.instantiateViewController(identifier: "ContactDetailsViewController")
            return try XCTUnwrap(homeVC as? ContactDetailsViewController)
        } else {
                // Fallback on earlier versions
            let homeVC =  sb.instantiateViewController(withIdentifier: "ContactDetailsViewController")
            return try XCTUnwrap(homeVC as? ContactDetailsViewController)
            
        }
    }
}
