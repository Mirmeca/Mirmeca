//
//  TermGateway.swift
//  Mirmeca
//
//  Created by solal on 2/08/2015.
//  Copyright (c) 2015 Mirmeca. All rights reserved.
//

import Alamofire
import ObjectMapper

struct TermGateway: GatewayProtocol {
    
    private var url: String?
    
    init(endpoint: String, env: String?) {
        let env = EnvManager.sharedInstance.getEnv(env)
        self.url = "\(env)/\(endpoint)"
    }
    
    func request(completion: (value: AnyObject?, error: NSError?) -> Void) {
        Alamofire.request(.GET, self.url!).responseJSON { (_, _, JSON, _) in
            var value: Term?
            var error: NSError?
            
            if (JSON != nil) {
                if let mappedObject = Mapper<Term>().map(JSON) {
                    value = mappedObject
                } else {
                    error = NSError(domain: self.url!, code: 303, userInfo: nil)
                }
            } else {
                error = NSError(domain: self.url!, code: 302, userInfo: nil)
            }
            
            completion(value: value, error: error)
        }
    }
    
}
