//
//  Comment.swift
//  Mirmeca
//
//  Created by solal on 1/08/2015.
//  Copyright (c) 2015 Mirmeca. All rights reserved.
//

import ObjectMapper

public class Comment: Mappable {
    
    public var id: Int?
    public var post: Int?
    public var content: String?
    public var status: String?
    public var type: String?
    public var parent: Int?
    public var author: Author?
    public var date: String?
    public var dateTz: String?
    public var dateGmt: String?
    
    required public init?(_ map: Map) {}
    
    public func mapping(map: Map) {
        id      <- map["ID"]
        post    <- map["post"]
        content <- map["content"]
        status  <- map["status"]
        type    <- map["type"]
        parent  <- map["parent"]
        author  <- map["author"]
        date    <- map["date"]
        dateTz  <- map["date_tz"]
        dateGmt <- map["date_gmt"]
    }
    
}
