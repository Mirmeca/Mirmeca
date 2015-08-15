//
//  Author.swift
//  Mirmeca
//
//  Created by solal on 1/08/2015.
//  Copyright (c) 2015 Mirmeca. All rights reserved.
//

import ObjectMapper

public class Author: Mappable {
    
    public var id: Int?
    public var username: String?
    public var name: String?
    public var firstName: String?
    public var lastName: String?
    public var nickname: String?
    public var slug: String?
    public var url: String?
    public var avatar: String?
    public var description: String?
    public var registered: String?
    
    public class func newInstance(map: Map) -> Mappable? {
        return Author()
    }
    
    public func mapping(map: Map) {
        id          <- map["ID"]
        username    <- map["username"]
        name        <- map["name"]
        firstName   <- map["first_name"]
        lastName    <- map["last_name"]
        nickname    <- map["nickname"]
        slug        <- map["slug"]
        url         <- map["URL"]
        avatar      <- map["avatar"]
        description <- map["description"]
        registered  <- map["registered"]
    }
    
}
