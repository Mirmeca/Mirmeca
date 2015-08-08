//
//  AttachmentSizeTestCase.swift
//  Mirmeca
//
//  Created by solal on 1/08/2015.
//  Copyright (c) 2015 Mirmeca. All rights reserved.
//

import UIKit
import XCTest
import ObjectMapper

class AttachmentSizeTestCase: XCTestCase {
    
    func attachmentSize() -> AttachmentSize {
        let path = NSBundle(identifier: "com.Mirmeca")!.pathForResource("attachmentSize", ofType: "json")
        let json = NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
        return Mapper<AttachmentSize>().map(json)!
    }

    func testWidth() {
        let attachmentSize = self.attachmentSize()
        XCTAssertEqual(attachmentSize.width!, 150, "Wrong Width")
    }
    
    func testHeight() {
        let attachmentSize = self.attachmentSize()
        XCTAssertEqual(attachmentSize.height!, 150, "Wrong Height")
    }
    
    func testFile() {
        let attachmentSize = self.attachmentSize()
        XCTAssertEqual(attachmentSize.file!, "hello-world-150x150.jpg", "Wrong File")
    }
    
    func testMimeType() {
        let attachmentSize = self.attachmentSize()
        XCTAssertEqual(attachmentSize.mimeType!, "image/jpeg", "Wrong MimeType")
    }
    
    func testUrl() {
        let attachmentSize = self.attachmentSize()
        XCTAssertEqual(attachmentSize.url!, "http://localhost:8888/wp-content/uploads/2015/07/hello-world-150x150.jpg", "Wrong URL")
    }

}
