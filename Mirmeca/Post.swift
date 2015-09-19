//
//  Post.swift
//  Mirmeca
//
//  Created by solal on 1/08/2015.
//  Copyright (c) 2015 Mirmeca. All rights reserved.
//

import ObjectMapper

public class Post: Mappable {
    
    public var id: Int?
    public var title: String?
    public var status: String?
    public var type: String?
    public var author: Author?
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
    public var featuredImage: FeaturedImage?
    public var categories: [Term]?
    public var tags: [Term]?
    public var featuredImageUrl: NSURL {
        get {
            if self.featuredImage != nil {
                return NSURL(string: self.featuredImage!.guid!)!
            } else {
                return NSURL(string: "")!
            }
        }
    }
    
    required public init?(_ map: Map) {}
    
    public func mapping(map: Map) {
        id             <- map["ID"]
        title          <- map["title"]
        status         <- map["status"]
        type           <- map["type"]
        author         <- map["author"]
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
        featuredImage  <- map["featured_image"]
        categories     <- map["terms.category"]
        tags           <- map["terms.post_tag"]
    }
    
}
