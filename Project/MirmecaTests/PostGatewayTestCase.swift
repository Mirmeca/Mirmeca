//
//  PostGatewayTestCase.swift
//  Mirmeca
//
//  Created by solal on 2/08/2015.
//  Copyright (c) 2015 Mirmeca. All rights reserved.
//

import UIKit
import XCTest

class PostGatewayTestCase: XCTestCase {
    
    func envSetUp() {
        let path = NSBundle(identifier: "com.Mirmeca")!.resourcePath
        let envs = ["test": "file://\(path!)"]
        MirmecaEnv.sharedInstance.defineEnvs(envs, defaultEnv: "test")
    }
    
    func testGetSinglePost() {
        let loadedExpectation = expectationWithDescription("Get a single post")
        self.envSetUp()
        
        PostGateway(endpoint: "post.json", env: nil).request({ (value: AnyObject?, error: NSError?) -> Void in
            if (error != nil) {
                XCTFail("Call to get single post returned an error")
            } else {
                let post = value as! Post
                XCTAssertEqual(post.id!, 1, "Did not fetch the proper post ID")
            }
            
            loadedExpectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(10, handler: { error in
            XCTAssertNil(error, "Failed to load the proper post")
        })
    }
    
    func testGetSinglePostError() {
        let loadedExpectation = expectationWithDescription("Get an error for a single post")
        self.envSetUp()
        
        PostGateway(endpoint: "post-y.json", env: nil).request({ (value: AnyObject?, error: NSError?) -> Void in
            if (error != nil) {
                XCTAssertNotNil(error!, "Error should not be nil")
            } else {
                XCTFail("Call to get single post did not return an error")
            }
            
            loadedExpectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(10, handler: { error in
            XCTAssertNil(error, "Failed to get an error")
        })
    }
    
}
