//
//  TermsGatewayTestCase.swift
//  Mirmeca
//
//  Created by solal on 2/08/2015.
//  Copyright (c) 2015 Mirmeca. All rights reserved.
//

import UIKit
import XCTest

class TermsGatewayTestCase: XCTestCase {
    
    func envSetUp() {
        let path = NSBundle(identifier: "com.Mirmeca")!.resourcePath
        let envs = ["test": "file://\(path!)"]
        EnvManager.sharedInstance.defineEnvs(envs, defaultEnv: "test")
    }
    
    func testGetSingleTerm() {
        let loadedExpectation = expectationWithDescription("Get a list of terms")
        self.envSetUp()
        
        TermsGateway(endpoint: "terms.json", env: nil).request({ (value: AnyObject?, error: NSError?) -> Void in
            if (error != nil) {
                XCTFail("Call to get a list of terms returned an error")
            } else {
                let terms = value as! [Term]
                XCTAssertEqual(terms.count, 1, "Did not fetch the proper number of terms")
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
        
        TermsGateway(endpoint: "terms-y.json", env: nil).request({ (value: AnyObject?, error: NSError?) -> Void in
            if (error != nil) {
                XCTAssertNotNil(error!, "Error should not be nil")
            } else {
                XCTFail("Call to get a list of terms did not return an error")
            }
            
            loadedExpectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(10, handler: { error in
            XCTAssertNil(error, "Failed to get an error")
        })
    }
    
}
