//
//  CommentsGateway.swift
//  Mirmeca
//
//  Created by solal on 2/08/2015.
//  Copyright (c) 2015 Mirmeca. All rights reserved.
//

import Alamofire
import ObjectMapper

public struct CommentsGateway: GatewayProtocol {
    
    private var url: String?
    
    public init(endpoint: String, env: String?) {
        let env = MirmecaEnv.sharedInstance.getEnv(env)
        self.url = "\(env)/\(endpoint)"
    }
    
    public func request(completion: (value: AnyObject?, error: NSError?) -> Void) {
        Alamofire.request(.GET, self.url!).responseJSON { _, _, result in
            var value: [Comment]?
            var error: NSError?
            
            if (result.isSuccess) {
                if let mappedObject = self.parseResponse(result.value!) {
                    value = mappedObject
                } else {
                    error = NSError(domain: self.url!, code: 302, userInfo: nil)
                }
            } else {
                error = NSError(domain: self.url!, code: 302, userInfo: nil)
            }
            
            completion(value: value, error: error)
        }
    }
    
    private func parseResponse(JSON: AnyObject) -> [Comment]? {
        var comments = [Comment]()
        for comment in JSON as! [AnyObject] {
            comments.append( Mapper<Comment>().map(comment)! )
        }
        
        return comments
    }
    
}
