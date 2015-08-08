//
//  AttachmentMeta.swift
//  Mirmeca
//
//  Created by solal on 1/08/2015.
//  Copyright (c) 2015 Mirmeca. All rights reserved.
//

import ObjectMapper

public class AttachmentMeta: Mappable {
    
    public var width: Int?
    public var height: Int?
    public var file: String?
    public var thumbnail: AttachmentSize?
    public var medium: AttachmentSize?
    public var large: AttachmentSize?
    
    public class func newInstance() -> Mappable {
        return AttachmentMeta()
    }
    
    public func mapping(map: Map) {
        width     <- map["width"]
        height    <- map["height"]
        file      <- map["file"]
        thumbnail <- map["sizes.thumbnail"]
        medium    <- map["sizes.medium"]
        large     <- map["sizes.large"]
    }
    
}
