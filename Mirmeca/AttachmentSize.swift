//
//  AttachmentSize.swift
//  Mirmeca
//
//  Created by solal on 1/08/2015.
//  Copyright (c) 2015 Mirmeca. All rights reserved.
//

import ObjectMapper

public class AttachmentSize: Mappable {
    
    public var width: Int?
    public var height: Int?
    public var file: String?
    public var mimeType: String?
    public var url: String?
    
    required public init?(_ map: Map) {}
    
    public func mapping(map: Map) {
        width    <- map["width"]
        height   <- map["height"]
        file     <- map["file"]
        mimeType <- map["mime-type"]
        url      <- map["url"]
    }
    
}
