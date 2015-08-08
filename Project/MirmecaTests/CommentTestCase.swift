//
//  CommentTestCase.swift
//  Mirmeca
//
//  Created by solal on 1/08/2015.
//  Copyright (c) 2015 Mirmeca. All rights reserved.
//

import UIKit
import XCTest
import ObjectMapper

class CommentTestCase: XCTestCase {
    
    func comment() -> Comment {
        let path = NSBundle(identifier: "com.Mirmeca")!.pathForResource("comment", ofType: "json")
        let json = NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
        return Mapper<Comment>().map(json)!
    }
    
    func author() -> Author {
        let path = NSBundle(identifier: "com.Mirmeca")!.pathForResource("author", ofType: "json")
        let json = NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
        return Mapper<Author>().map(json)!
    }
    
    func testID() {
        let comment = self.comment()
        XCTAssertEqual(comment.id!, 1, "Wrong ID")
    }
    
    func testPost() {
        let comment = self.comment()
        XCTAssertEqual(comment.post!, 1, "Wrong Post")
    }
    
    func testContent() {
        let comment = self.comment()
        XCTAssertEqual(comment.content!, "<p>Hi, this is a comment.<br />\nTo delete a comment, just log in and view the post&#039;s comments. There you will have the option to edit or delete them.</p>\n", "Wrong Content")
    }
    
    func testStatus() {
        let comment = self.comment()
        XCTAssertEqual(comment.status!, "approved", "Wrong Status")
    }
    
    func testType() {
        let comment = self.comment()
        XCTAssertEqual(comment.type!, "comment", "Wrong Type")
    }
    
    func testParent() {
        let comment = self.comment()
        XCTAssertEqual(comment.parent!, 0, "Wrong Parent")
    }
    
    func testDate() {
        let comment = self.comment()
        XCTAssertEqual(comment.date!, "2015-07-27T10:50:05", "Wrong Date")
    }
    
    func testDateTz() {
        let comment = self.comment()
        XCTAssertEqual(comment.dateTz!, "UTC", "Wrong DateTz")
    }
    
    func testDateGmt() {
        let comment = self.comment()
        XCTAssertEqual(comment.dateGmt!, "2015-07-27T10:50:05", "Wrong DateGmt")
    }
    
    func testAuthor() {
        let comment = self.comment()
        XCTAssertEqual(comment.author!.id!, 0, "Wrong Author")
    }
    
}
