//
//  EnvManagerTestCase.swift
//  Mirmeca
//
//  Created by solal on 2/08/2015.
//  Copyright (c) 2015 Mirmeca. All rights reserved.
//

import UIKit
import XCTest

class EnvManagerTestCase: XCTestCase {
    
    func testEnvSetup() {
        let envs = ["dev": "http://localhost:8888/wp-json"]
        MirmecaEnv.sharedInstance.defineEnvs(envs, defaultEnv: "dev")
        XCTAssertEqual(MirmecaEnv.sharedInstance.getEnv(nil), "http://localhost:8888/wp-json", "Unknown env was set")
    }
    
    func testEnvSetupWithUnknownEnv() {
        let envs = ["dev": "http://localhost:8888/wp-json"]
        MirmecaEnv.sharedInstance.defineEnvs(envs, defaultEnv: "staging")
        XCTAssertEqual(MirmecaEnv.sharedInstance.getEnv(nil), "", "Env should be empty string")
    }
    
    func testGetEnv() {
        let envs = ["dev": "http://localhost:8888/wp-json", "staging": "http://staging.example.com/wp-json"]
        MirmecaEnv.sharedInstance.defineEnvs(envs, defaultEnv: "dev")
        XCTAssertEqual(MirmecaEnv.sharedInstance.getEnv("staging"), "http://staging.example.com/wp-json", "Unknown env was requested")
    }
    
    func testGetEnvWithUnknownEnv() {
        let envs = ["dev": "http://localhost:8888/wp-json"]
        MirmecaEnv.sharedInstance.defineEnvs(envs, defaultEnv: "dev")
        XCTAssertEqual(MirmecaEnv.sharedInstance.getEnv("prod"), "", "Env should be empty string")
    }

}
