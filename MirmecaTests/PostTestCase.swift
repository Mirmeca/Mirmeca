//
//  PostTestCase.swift
//  Mirmeca
//
//  Created by solal on 1/08/2015.
//  Copyright (c) 2015 Mirmeca. All rights reserved.
//

import UIKit
import XCTest
import ObjectMapper

class PostTestCase: XCTestCase {
    
    func post() -> Post {
        let path = NSBundle(identifier: "com.Mirmeca")!.pathForResource("post", ofType: "json")
        let json = try! NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        return Mapper<Post>().map(json)!
    }
    
    func testID() {
        let post = self.post()
        XCTAssertEqual(post.id!, 1, "Wrong ID")
    }
    
    func testTitle() {
        let post = self.post()
        XCTAssertEqual(post.title!, "Hello world!", "Wrong Title")
    }
    
    func testStatus() {
        let post = self.post()
        XCTAssertEqual(post.status!, "publish", "Wrong Status")
    }
    
    func testType() {
        let post = self.post()
        XCTAssertEqual(post.type!, "post", "Wrong Type")
    }
    
    func testContent() {
        let post = self.post()
        XCTAssertEqual(post.content!, "<p>Welcome to WordPress. This is your first post. Edit or delete it, then start blogging!</p>\n", "Wrong Content")
    }
    
    func testParent() {
        let post = self.post()
        XCTAssertNil(post.parent, "Parent should be nil")
    }
    
    func testLink() {
        let post = self.post()
        XCTAssertEqual(post.link!, "http://localhost:8888/2015/07/27/hello-world/", "Wrong Link")
    }
    
    func testDate() {
        let post = self.post()
        XCTAssertEqual(post.date!, "2015-07-27T10:50:05", "Wrong Date")
    }
    
    func testModified() {
        let post = self.post()
        XCTAssertEqual(post.modified!, "2015-08-01T06:08:16", "Wrong Modified")
    }
    
    func testFormat() {
        let post = self.post()
        XCTAssertEqual(post.format!, "standard", "Wrong Format")
    }
    
    func testSlug() {
        let post = self.post()
        XCTAssertEqual(post.slug!, "hello-world", "Wrong Slug")
    }
    
    func testGuid() {
        let post = self.post()
        XCTAssertEqual(post.guid!, "http://localhost:8888/?p=1", "Wrong Guid")
    }
    
    func testExcerpt() {
        let post = self.post()
        XCTAssertEqual(post.excerpt!, "<p>Welcome to WordPress. This is your first post. Edit or delete it, then start blogging!</p>\n", "Wrong Excerpt")
    }
    
    func testMenuOrder() {
        let post = self.post()
        XCTAssertEqual(post.menuOrder!, 0, "Wrong Menu Order")
    }
    
    func testCommentStatus() {
        let post = self.post()
        XCTAssertEqual(post.commentStatus!, "open", "Wrong Comment Status")
    }
    
    func testPingStatus() {
        let post = self.post()
        XCTAssertEqual(post.pingStatus!, "open", "Wrong Ping Status")
    }
    
    func testSticky() {
        let post = self.post()
        XCTAssertFalse(post.sticky!, "Wrong Sticky Status")
    }
    
    func testDateTz() {
        let post = self.post()
        XCTAssertEqual(post.dateTz!, "UTC", "Wrong Date Tz")
    }
    
    func testDateGmt() {
        let post = self.post()
        XCTAssertEqual(post.dateGmt!, "2015-07-27T10:50:05", "Wrong Date Gmt")
    }
    
    func testModifiedTz() {
        let post = self.post()
        XCTAssertEqual(post.modifiedTz!, "UTC", "Wrong Modified Tz")
    }
    
    func testModifiedGmt() {
        let post = self.post()
        XCTAssertEqual(post.modifiedGmt!, "2015-08-01T06:08:16", "Wrong Modified Gmt")
    }
    
    func testAuthor() {
        let post = self.post()
        XCTAssertEqual(post.author!.id!, 1, "Wrong Author")
    }
    
    func testFeaturedImage() {
        let post = self.post()
        XCTAssertEqual(post.featuredImage!.id!, 7085, "Wrong Featured Image")
    }
    
    func testCategories() {
        let post = self.post()
        XCTAssertEqual(post.categories!.count, 2, "Wrong number of Categories")
    }
    
    func testTags() {
        let post = self.post()
        XCTAssertEqual(post.tags!.count, 2, "Wrong number of Tags")
    }
    
    func testFeaturedImageUrl() {
        let post = self.post()
        XCTAssertEqual(post.featuredImageUrl, NSURL(string: "http://localhost:8888/wp-content/uploads/2015/07/hello-world.jpg")!, "Wrong Featured Image URL")
    }
    
}
