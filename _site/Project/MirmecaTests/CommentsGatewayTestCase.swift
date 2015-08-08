//
//  CommentsGatewayTestCase.swift
//  Mirmeca
//
//  Created by solal on 2/08/2015.
//  Copyright (c) 2015 Mirmeca. All rights reserved.
//

import UIKit
import XCTest

class CommentsGatewayTestCase: XCTestCase {
    
    func envSetUp() {
        let path = NSBundle(identifier: "com.Mirmeca")!.resourcePath
        let envs = ["test": "file://\(path!)"]
        MirmecaEnv.sharedInstance.defineEnvs(envs, defaultEnv: "test")
    }
    
    func testGetCommentsList() {
        let loadedExpectation = expectationWithDescription("Get a list of comments")
        self.envSetUp()
        
        CommentsGateway(endpoint: "comments.json", env: nil).request({ (value: AnyObject?, error: NSError?) -> Void in
            if (error != nil) {
                XCTFail("Call to get a list of comments returned an error")
            } else {
                let comments = value as! [Comment]
                XCTAssertEqual(comments.count, 1, "Did not fetch the proper number of comments")
            }
            
            loadedExpectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(10, handler: { error in
            XCTAssertNil(error, "Failed to load the proper comment")
        })
    }
    
    func testGetCommentsListCommentError() {
        let loadedExpectation = expectationWithDescription("Get an error for a single comment")
        self.envSetUp()
        
        CommentsGateway(endpoint: "comments-y.json", env: nil).request({ (value: AnyObject?, error: NSError?) -> Void in
            if (error != nil) {
                XCTAssertNotNil(error!, "Error should not be nil")
            } else {
                XCTFail("Call to get a list of comments did not return an error")
            }
            
            loadedExpectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(10, handler: { error in
            XCTAssertNil(error, "Failed to get an error")
        })
    }
    
}
