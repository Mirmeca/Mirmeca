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
        let envs = ["test": "https://gist.githubusercontent.com/solal/a648d268da09d245f221/raw/b064c7e84712223bf5c53b4cd763f916ad856753/"]
        EnvManager.sharedInstance.defineEnvs(envs, defaultEnv: "test")
    }
    
    func testGetSinglePost() {
        let loadedExpectation = expectationWithDescription("Get a single post")
        self.envSetUp()
        
        PostGateway(endpoint: "mirmeca-post-1", env: nil).request({ (value: AnyObject?, error: NSError?) -> Void in
            if (error != nil) {
                XCTFail("Call to get single post returned an error")
            } else {
                let loadedPost = value as! Post
                XCTAssertEqual(loadedPost.id!, 1, "Did not fetch the proper post ID")
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
        
        PostGateway(endpoint: "mirmeca-post-2", env: nil).request({ (value: AnyObject?, error: NSError?) -> Void in
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
