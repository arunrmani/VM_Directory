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
