//
//  Term.swift
//  Mirmeca
//
//  Created by solal on 1/08/2015.
//  Copyright (c) 2015 Mirmeca. All rights reserved.
//

import ObjectMapper

public class Term: Mappable {
    
    public var id: Int?
    public var name: String?
    public var slug: String?
    public var description: String?
    public var taxonomy: String?
    public var parent: Int?
    public var count: Int?
    public var link: String?
    
    public class func newInstance() -> Mappable {
        return Term()
    }
    
    public func mapping(map: Map) {
        id          <- map["ID"]
        name        <- map["name"]
        slug        <- map["slug"]
        description <- map["description"]
        taxonomy    <- map["taxonomy"]
        parent      <- map["parent"]
        count       <- map["count"]
        link        <- map["link"]
    }
    
}
