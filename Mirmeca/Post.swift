//
//  Post.swift
//  Mirmeca
//
//  Created by solal on 1/08/2015.
//  Copyright (c) 2015 Mirmeca. All rights reserved.
//

import ObjectMapper

public class Post: Mappable {
    
    public var ID: Int?
    public var title: String?
    public var status: String?
    public var type: String?
    public var content: String?
    public var parent: Int?
    public var link: String?
    public var date: String?
    public var modified: String?
    public var format: String?
    public var slug: String?
    public var guid: String?
    public var excerpt: String?
    public var menuOrder: Int?
    public var commentStatus: String?
    public var pingStatus: String?
    public var sticky: Bool?
    public var dateTz: String?
    public var dateGmt: String?
    public var modifiedTz: String?
    public var modifiedGmt: String?
    
    public class func newInstance() -> Mappable {
        return Post()
    }
    
    public func mapping(map: Map) {
        ID             <- map["ID"]
        title          <- map["title"]
        status         <- map["status"]
        type           <- map["type"]
        content        <- map["content"]
        parent         <- map["parent"]
        link           <- map["link"]
        date           <- map["date"]
        modified       <- map["modified"]
        format         <- map["format"]
        slug           <- map["slug"]
        guid           <- map["guid"]
        excerpt        <- map["excerpt"]
        menuOrder      <- map["menu_order"]
        commentStatus  <- map["comment_status"]
        pingStatus     <- map["ping_status"]
        sticky         <- map["sticky"]
        dateTz         <- map["date_tz"]
        dateGmt        <- map["date_gmt"]
        modifiedTz     <- map["modified_tz"]
        modifiedGmt    <- map["modified_gmt"]
    }
    
}
