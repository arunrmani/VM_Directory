//
//  VM_DirectoryUITests.swift
//  VM DirectoryUITests
//
//  Created by Safe City Mac 001 on 01/08/2022.
//

import XCTest

class VM_DirectoryUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
//
    func testNormalFlow() throws {
        // UI tests must launch the application that they test.


        let app = XCUIApplication()
        app.launch()
        let exp = expectation(description: "Waiting for Launch")
        exp.isInverted = true
        wait(for: [exp], timeout: 3)

        let skipbutton = app.buttons[" "]
        XCTAssertTrue(skipbutton.exists)
        skipbutton.tap()

        let exp2 = expectation(description: "Waiting for API respose People")
        exp2.isInverted = true
        wait(for: [exp2], timeout: 3)

        let tablesQuery = app.tables
        XCTAssertTrue(tablesQuery.element.exists)


        let element = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.swipeUp()

        let roombtn = app.staticTexts["Rooms"]
        XCTAssertTrue(roombtn.exists)
        roombtn.tap()

        let exp3 = expectation(description: "Waiting for API respose Room")
        exp3.isInverted = true
        wait(for: [exp3], timeout: 3)

        XCTAssertTrue(tablesQuery.element.exists)

        let contactBtn = app.staticTexts["Contact"]
        XCTAssertTrue(contactBtn.exists)
        contactBtn.tap()

        XCTAssertTrue(tablesQuery.element.exists)

        
        let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0)
        
       let searchBtn =  element2.children(matching: .button).matching(identifier: " ").element(boundBy: 1)
        XCTAssertTrue(searchBtn.exists)
        searchBtn.tap()
        
        let searcgTxt = app.textFields["Serach"]
        XCTAssertTrue(searcgTxt.exists)
        searcgTxt.tap()
        
        let mKey = app.keys["m"]
        mKey.tap()

        element2.tap()
        
        
        let cell = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Maggie Brekke"]/*[[".cells.staticTexts[\"Maggie Brekke\"]",".staticTexts[\"Maggie Brekke\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        XCTAssertTrue(cell.exists)
        cell.tap()
        
        XCUIApplication().buttons[" "].tap()


    }

    
    func testNormalFlow3() throws {
        
        
        let app = XCUIApplication()
        app.staticTexts["Maggie"].tap()
        app.staticTexts["Future Functionality Strategist"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 2).buttons[" "].tap()

        
        
    }
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}




