//
//  AuthorTestCase.swift
//  Mirmeca
//
//  Created by solal on 1/08/2015.
//  Copyright (c) 2015 Mirmeca. All rights reserved.
//

import UIKit
import XCTest
import ObjectMapper

class AuthorTestCase: XCTestCase {
    
    func author() -> Author {
        let path = NSBundle(identifier: "com.Mirmeca")!.pathForResource("author", ofType: "json")
        let json = try! NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        return Mapper<Author>().map(json)!
    }
    
    func testID() {
        let author = self.author()
        XCTAssertEqual(author.id!, 1, "Wrong ID")
    }
    
    func testUsername() {
        let author = self.author()
        XCTAssertEqual(author.username!, "admin", "Wrong Username")
    }
    
    func testName() {
        let author = self.author()
        XCTAssertEqual(author.name!, "Frank", "Wrong Name")
    }
    
    func testFirstName() {
        let author = self.author()
        XCTAssertEqual(author.firstName!, "Frank", "Wrong First Name")
    }
    
    func testLastName() {
        let author = self.author()
        XCTAssertEqual(author.lastName!, "Sinatra", "Wrong Last Name")
    }
    
    func testNickname() {
        let author = self.author()
        XCTAssertEqual(author.nickname!, "franky", "Wrong Nickname")
    }
    
    func testSlug() {
        let author = self.author()
        XCTAssertEqual(author.slug!, "frank", "Wrong Slug")
    }
    
    func testUrl() {
        let author = self.author()
        XCTAssertEqual(author.url!, "", "Wrong Url")
    }
    
    func testAvatar() {
        let author = self.author()
        XCTAssertEqual(author.avatar!, "http://1.gravatar.com/avatar/?s=96", "Wrong Avatar")
    }
    
    func testDescription() {
        let author = self.author()
        XCTAssertEqual(author.description!, "", "Wrong Description")
    }
    
    func testRegistered() {
        let author = self.author()
        XCTAssertEqual(author.registered!, "2015-07-27T10:50:05+00:00", "Wrong Registered")
    }
    
}
