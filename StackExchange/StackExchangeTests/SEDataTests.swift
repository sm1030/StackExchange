//
//  DataCacheTests.swift
//  StackExchange
//
//  Created by Alexandre Malkov on 30/11/2016.
//  Copyright © 2016 Alexandre Malkov. All rights reserved.
//

import XCTest
@testable import StackExchange

class SEDataTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        SEData.deleteAll()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSaveAndGetImage() {
        
        var data1: Data? = nil
        var data2: Data? = nil
        
        // Make sure there is no data
        XCTAssertEqual(SEData.getAllItems().count, 0)
        
        // Save data1
        if let image = UIImage(named: "User.png") {
            data1 = UIImagePNGRepresentation(image)
            SEData.saveData(data: data1!, forURL: "data1")
        } else {
            XCTFail()
        }
        
        // Should be 1 item
        XCTAssertEqual(SEData.getAllItems().count, 1)
        
        // Save data2
        if let image = UIImage(named: "User.png") {
            data2 = UIImagePNGRepresentation(image)
            SEData.saveData(data: data2!, forURL: "data2")
        } else {
            XCTFail()
        }
        
        // Should be 2 items
        XCTAssertEqual(SEData.getAllItems().count, 2)
        
        //Check results
        let newData1 = SEData.getData(forURL: "data1")
        let newData2 = SEData.getData(forURL: "data2")
        XCTAssertEqual(newData1, data1)
        XCTAssertEqual(newData2, data2)
        
        // Delete all
        SEData.deleteAll()
        
        // Should be 0 items
        XCTAssertEqual(SEData.getAllItems().count, 0)
    }
    
}
