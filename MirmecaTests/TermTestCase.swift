//
//  TermTestCase.swift
//  Mirmeca
//
//  Created by solal on 1/08/2015.
//  Copyright (c) 2015 Mirmeca. All rights reserved.
//

import UIKit
import XCTest
import ObjectMapper

class TermTestCase: XCTestCase {
    
    func term() -> Term {
        let path = NSBundle(identifier: "com.Mirmeca")!.pathForResource("term", ofType: "json")
        let json = try! NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        return Mapper<Term>().map(json)!
    }
    
    func testID() {
        let term = self.term()
        XCTAssertEqual(term.id!, 378, "Wrong ID")
    }
    
    func testName() {
        let term = self.term()
        XCTAssertEqual(term.name!, "iOS", "Wrong Name")
    }
    
    func testSlug() {
        let term = self.term()
        XCTAssertEqual(term.slug!, "ios", "Wrong Slug")
    }
    
    func testDescription() {
        let term = self.term()
        XCTAssertEqual(term.description!, "", "Wrong Description")
    }
    
    func testTaxonomy() {
        let term = self.term()
        XCTAssertEqual(term.taxonomy!, "category", "Wrong Taxonomy")
    }
    
    func testParent() {
        let term = self.term()
        XCTAssertNil(term.parent, "Comment should not have a parent")
    }
    
    func testCount() {
        let term = self.term()
        XCTAssertEqual(term.count!, 1, "Wrong Count")
    }
    
    func testLink() {
        let term = self.term()
        XCTAssertEqual(term.link!, "http://localhost:8888/category/ios/", "Wrong Link")
    }
    
}
