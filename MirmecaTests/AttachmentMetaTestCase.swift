//
//  AttachmentMetaTestCase.swift
//  Mirmeca
//
//  Created by solal on 1/08/2015.
//  Copyright (c) 2015 Mirmeca. All rights reserved.
//

import UIKit
import XCTest
import ObjectMapper

class AttachmentMetaTestCase: XCTestCase {
    
    func attachmentMeta() -> AttachmentMeta {
        let path = NSBundle(identifier: "com.Mirmeca")!.pathForResource("attachmentMeta", ofType: "json")
        let json = try! NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
        return Mapper<AttachmentMeta>().map(json)!
    }
    
    func testWidth() {
        let attachmentMeta = self.attachmentMeta()
        XCTAssertEqual(attachmentMeta.width!, 675, "Wrong Width")
    }
    
    func testHeight() {
        let attachmentMeta = self.attachmentMeta()
        XCTAssertEqual(attachmentMeta.height!, 350, "Wrong Height")
    }
    
    func testFile() {
        let attachmentMeta = self.attachmentMeta()
        XCTAssertEqual(attachmentMeta.file!, "2015/07/hello-world.jpg", "Wrong File")
    }
    
    func testThumbnail() {
        let attachmentMeta = self.attachmentMeta()
        XCTAssertEqual(attachmentMeta.thumbnail!.file!, "hello-world-150x150.jpg", "Wrong Thumbnail")
    }
    
    func testMedium() {
        let attachmentMeta = self.attachmentMeta()
        XCTAssertEqual(attachmentMeta.medium!.file!, "hello-world-300x156.jpg", "Wrong Medium")
    }
    
    func testLarge() {
        let attachmentMeta = self.attachmentMeta()
        XCTAssertNil(attachmentMeta.large, "Large should be nil")
    }
    
}
