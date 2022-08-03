//
//  VM_DirectoryTests.swift
//  VM DirectoryTests
//
//  Created by Safe City Mac 001 on 01/08/2022.
//

import XCTest
@testable import VM_Directory

class VM_LaunchTests: XCTestCase {

    func test_canInit() throws{
        _ = try makeSUT()
    }
    func test_launchViewModel() throws{
        let vm = LaunchViewModel()
        //initValue
        XCTAssertEqual(vm.quoteStr.value, "")
        XCTAssertEqual(vm.quoteAuthorStr.value, "")
        XCTAssertEqual(vm.finishLaunchAnimation.value, false)
        XCTAssertEqual(vm.isNetworkAvailable.value, true)
        vm.startLaunchAnimation()
        XCTAssertEqual(vm.isNetworkAvailable.value, true)
        XCTAssertGreaterThan(vm.quoteStr.value.count, 0)
        XCTAssertGreaterThan(vm.quoteAuthorStr.value.count, 0)

        vm.goToNextViewController()
        XCTAssertEqual(vm.isNetworkAvailable.value, vm.finishLaunchAnimation.value)
    }
    
    func test_bindingValues() throws{
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        sut.launchVM.quoteStr.value = "Sample quote"
        XCTAssertEqual(sut.lbl_quotes.text, "Sample quote")
        sut.launchVM.quoteAuthorStr.value = "Sample Autor"
        XCTAssertEqual(sut.lbl_quotesAuthor.text, "Sample Autor")

        
    }
    
    func test_skipBtnAction() throws{
        let sut = try makeSUT()
        sut.loadViewIfNeeded()
        sut.launchVM.startLaunchAnimation()
        let btn = UIButton()
        sut.skipBtnAction(btn)
        
        XCTAssertEqual(sut.launchVM.isNetworkAvailable.value, sut.launchVM.finishLaunchAnimation.value)

    }
    

}


extension VM_LaunchTests{
    private func makeSUT() throws -> LaunchViewController{
        let bundle = Bundle(for: LaunchViewController.self)
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        let initialVC = sb.instantiateInitialViewController()
        let navigation = try XCTUnwrap( initialVC as? UINavigationController)
        return try XCTUnwrap(navigation.topViewController as? LaunchViewController )
    }
}
