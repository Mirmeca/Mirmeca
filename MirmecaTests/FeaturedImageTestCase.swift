//
//  FeaturedImageTestCase.swift
//  Mirmeca
//
//  Created by solal on 2/08/2015.
//  Copyright (c) 2015 Mirmeca. All rights reserved.
//

import UIKit
import XCTest
import ObjectMapper

class FeaturedImageTestCase: XCTestCase {
    
    func featuredImage() -> FeaturedImage {
        let path = NSBundle(identifier: "com.Mirmeca")!.pathForResource("featuredImage", ofType: "json")
        let json = try! NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        return Mapper<FeaturedImage>().map(json)!
    }
    
    func testID() {
        let featuredImage = self.featuredImage()
        XCTAssertEqual(featuredImage.id!, 7085, "Wrong ID")
    }
    
    func testTitle() {
        let featuredImage = self.featuredImage()
        XCTAssertEqual(featuredImage.title!, "hello-world", "Wrong Title")
    }
    
    func testStatus() {
        let featuredImage = self.featuredImage()
        XCTAssertEqual(featuredImage.status!, "inherit", "Wrong Status")
    }
    
    func testType() {
        let featuredImage = self.featuredImage()
        XCTAssertEqual(featuredImage.type!, "attachment", "Wrong Type")
    }
    
    func testAuthor() {
        let featuredImage = self.featuredImage()
        XCTAssertNil(featuredImage.author, "Author should be nil")
    }
    
    func testContent() {
        let featuredImage = self.featuredImage()
        XCTAssertEqual(featuredImage.content!, "<p class='attachment'><a href='http://localhost:8888/wp-content/uploads/2015/07/hello-world.jpg'><img width='300' height='156' src='http://localhost:8888/wp-content/uploads/2015/07/hello-world-300x156.jpg' class='attachment-medium' alt='HelloWorldvisualisation' /></a></p> <p>Just some Hello World image.</p>", "Wrong Content")
    }
    
    func testParent() {
        let featuredImage = self.featuredImage()
        XCTAssertEqual(featuredImage.parent!, 1, "Wrong Parent")
    }
    
    func testLink() {
        let featuredImage = self.featuredImage()
        XCTAssertEqual(featuredImage.link!, "http://localhost:8888/2015/07/27/hello-world/hello-world-2/", "Wrong Link")
    }
    
    func testDate() {
        let featuredImage = self.featuredImage()
        XCTAssertEqual(featuredImage.date!, "2015-08-01T06:07:12", "Wrong Date")
    }
    
    func testModified() {
        let featuredImage = self.featuredImage()
        XCTAssertEqual(featuredImage.modified!, "2015-08-01T06:07:57", "Wrong Modified")
    }
    
    func testFormat() {
        let featuredImage = self.featuredImage()
        XCTAssertEqual(featuredImage.format!, "standard", "Wrong Format")
    }
    
    func testSlug() {
        let featuredImage = self.featuredImage()
        XCTAssertEqual(featuredImage.slug!, "hello-world-2", "Wrong Slug")
    }
    
    func testGuid() {
        let featuredImage = self.featuredImage()
        XCTAssertEqual(featuredImage.guid!, "http://localhost:8888/wp-content/uploads/2015/07/hello-world.jpg", "Wrong Guid")
    }
    
    func testExcerpt() {
        let featuredImage = self.featuredImage()
        XCTAssertEqual(featuredImage.excerpt!, "<p>Hello World visualisation</p> ", "Wrong Excerpt")
    }
    
    func testMenuOrder() {
        let featuredImage = self.featuredImage()
        XCTAssertEqual(featuredImage.menuOrder!, 0, "Wrong MenuOrder")
    }
    
    func testCommentStatus() {
        let featuredImage = self.featuredImage()
        XCTAssertEqual(featuredImage.commentStatus!, "open", "Wrong Comment Status")
    }
    
    func testPingStatus() {
        let featuredImage = self.featuredImage()
        XCTAssertEqual(featuredImage.pingStatus!, "open", "Wrong Ping Status")
    }
    
    func testSticky() {
        let featuredImage = self.featuredImage()
        XCTAssertFalse(featuredImage.sticky!, "Sticky should be false")
    }
    
    func testDateTz() {
        let featuredImage = self.featuredImage()
        XCTAssertEqual(featuredImage.dateTz!, "UTC", "Wrong Date Tz")
    }
    
    func testDateGmt() {
        let featuredImage = self.featuredImage()
        XCTAssertEqual(featuredImage.dateGmt!, "2015-08-01T06:07:12", "Wrong Date Gmt")
    }
    
    func testModifiedTz() {
        let featuredImage = self.featuredImage()
        XCTAssertEqual(featuredImage.modifiedTz!, "UTC", "Wrong Modified Tz")
    }
    
    func testModifiedGmt() {
        let featuredImage = self.featuredImage()
        XCTAssertEqual(featuredImage.modifiedGmt!, "2015-08-01T06:07:57", "Wrong Modified Gmt")
    }
    
    func testTerms() {
        let featuredImage = self.featuredImage()
        XCTAssertEqual(featuredImage.terms!.count, 0, "Wrong number of Terms")
    }
    
    func testSource() {
        let featuredImage = self.featuredImage()
        XCTAssertEqual(featuredImage.source!, "http://localhost:8888/wp-content/uploads/2015/07/hello-world.jpg", "Wrong Source")
    }
    
    func testIsImage() {
        let featuredImage = self.featuredImage()
        XCTAssertTrue(featuredImage.isImage!, "Is Image should be true")
    }
    
    func testAttachmentMeta() {
        let featuredImage = self.featuredImage()
        XCTAssertEqual(featuredImage.attachmentMeta!.file!, "2015/07/hello-world.jpg", "Wrong Attachment Meta")
    }
    
}
