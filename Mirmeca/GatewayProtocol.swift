//
//  GatewayProtocol.swift
//  Mirmeca
//
//  Created by solal on 2/08/2015.
//  Copyright (c) 2015 Mirmeca. All rights reserved.
//

import Foundation

public protocol GatewayProtocol {
    
    init(endpoint: String, env: String?)
    func request(completion: (value: AnyObject?, error: NSError?) -> Void)
    
}
