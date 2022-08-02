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

}

extension HomePageTests{
    private func makeSUT()throws -> HomeViewController{
        let bundle = Bundle(for: HomeViewController.self)
        let sb = UIStoryboard(name: "Main", bundle: bundle)
        if #available(iOS 13.0, *) {
            let loginVC = sb.instantiateViewController(identifier: "HomeViewController")
            return try XCTUnwrap(loginVC as? HomeViewController)
        } else {
                // Fallback on earlier versions
            let loginVC =  sb.instantiateViewController(withIdentifier: "TabBarController")
            return try XCTUnwrap(loginVC as? HomeViewController)

        }
    }
}
