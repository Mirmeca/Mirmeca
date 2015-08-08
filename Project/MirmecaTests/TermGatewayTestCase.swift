//
//  TermGatewayTestCase.swift
//  Mirmeca
//
//  Created by solal on 2/08/2015.
//  Copyright (c) 2015 Mirmeca. All rights reserved.
//

import UIKit
import XCTest

class TermGatewayTestCase: XCTestCase {
    
    func envSetUp() {
        let path = NSBundle(identifier: "com.Mirmeca")!.resourcePath
        let envs = ["test": "file://\(path!)"]
        MirmecaEnv.sharedInstance.defineEnvs(envs, defaultEnv: "test")
    }
    
    func testGetSingleTerm() {
        let loadedExpectation = expectationWithDescription("Get a single term")
        self.envSetUp()
        
        TermGateway(endpoint: "term.json", env: nil).request({ (value: AnyObject?, error: NSError?) -> Void in
            if (error != nil) {
                XCTFail("Call to get single term returned an error")
            } else {
                let term = value as! Term
                XCTAssertEqual(term.id!, 378, "Did not fetch the proper term ID")
            }
            
            loadedExpectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(10, handler: { error in
            XCTAssertNil(error, "Failed to load the proper term")
        })
    }
    
    func testGetSingleTermError() {
        let loadedExpectation = expectationWithDescription("Get an error for a single term")
        self.envSetUp()
        
        TermGateway(endpoint: "term-y.json", env: nil).request({ (value: AnyObject?, error: NSError?) -> Void in
            if (error != nil) {
                XCTAssertNotNil(error!, "Error should not be nil")
            } else {
                XCTFail("Call to get single term did not return an error")
            }
            
            loadedExpectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(10, handler: { error in
            XCTAssertNil(error, "Failed to get an error")
        })
    }
    
}
