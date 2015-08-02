//
//  CommentGatewayTestCase.swift
//  Mirmeca
//
//  Created by solal on 2/08/2015.
//  Copyright (c) 2015 Mirmeca. All rights reserved.
//

import UIKit
import XCTest

class CommentGatewayTestCase: XCTestCase {
    
    func envSetUp() {
        let path = NSBundle(identifier: "com.Mirmeca")!.resourcePath
        let envs = ["test": "file://\(path!)"]
        EnvManager.sharedInstance.defineEnvs(envs, defaultEnv: "test")
    }
    
    func testGetSingleComment() {
        let loadedExpectation = expectationWithDescription("Get a single comment")
        self.envSetUp()
        
        CommentGateway(endpoint: "comment.json", env: nil).request({ (value: AnyObject?, error: NSError?) -> Void in
            if (error != nil) {
                XCTFail("Call to get single comment returned an error")
            } else {
                let comment = value as! Comment
                XCTAssertEqual(comment.id!, 1, "Did not fetch the proper comment ID")
            }
            
            loadedExpectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(10, handler: { error in
            XCTAssertNil(error, "Failed to load the proper comment")
        })
    }
    
    func testGetSingleCommentError() {
        let loadedExpectation = expectationWithDescription("Get an error for a single comment")
        self.envSetUp()
        
        CommentGateway(endpoint: "comment-y.json", env: nil).request({ (value: AnyObject?, error: NSError?) -> Void in
            if (error != nil) {
                XCTAssertNotNil(error!, "Error should not be nil")
            } else {
                XCTFail("Call to get single comment did not return an error")
            }
            
            loadedExpectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(10, handler: { error in
            XCTAssertNil(error, "Failed to get an error")
        })
    }
    
}

