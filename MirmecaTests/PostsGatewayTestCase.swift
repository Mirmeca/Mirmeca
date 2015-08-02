//
//  PostsGatewayTestCase.swift
//  Mirmeca
//
//  Created by solal on 2/08/2015.
//  Copyright (c) 2015 Mirmeca. All rights reserved.
//

import UIKit
import XCTest

class PostsGatewayTestCase: XCTestCase {
    
    func envSetUp() {
        let envs = ["test": "https://gist.githubusercontent.com/solal/8b8eed8389f9a23d1def/raw/c38e84d954e665a2009236ffe8309e73b27a589e/"]
        EnvManager.sharedInstance.defineEnvs(envs, defaultEnv: "test")
    }
    
    func testGetSinglePost() {
        let loadedExpectation = expectationWithDescription("Get a list of posts")
        self.envSetUp()
        
        PostsGateway(endpoint: "mirmeca-posts", env: nil).request({ (value: AnyObject?, error: NSError?) -> Void in
            if (error != nil) {
                XCTFail("Call to get a list of posts returned an error")
            } else {
                let loadedPosts = value as! [Post]
                XCTAssertEqual(loadedPosts.count, 1, "Did not fetch the proper number of posts")
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
        
        PostsGateway(endpoint: "mirmeca-posts-0", env: nil).request({ (value: AnyObject?, error: NSError?) -> Void in
            if (error != nil) {
                XCTAssertNotNil(error!, "Error should not be nil")
            } else {
                XCTFail("Call to get a list of posts did not return an error")
            }
            
            loadedExpectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(10, handler: { error in
            XCTAssertNil(error, "Failed to get an error")
        })
    }
    
}
