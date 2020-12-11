//
//  MirmecaEnv.swift
//  Mirmeca
//
//  Created by solal on 2/08/2015.
//  Copyright (c) 2015 Mirmeca. All rights reserved.
//

import Foundation

public class MirmecaEnv {
    
    public static let sharedInstance = MirmecaEnv()
    
    private var envList: Dictionary<String, String>?
    private var setEnv: String?
    private var defaultEnv: String?
    private let warning = "\n***\nWARNING - Unknown env was passed. Requests will return no data.\n***\n"
    
    public func defineEnvs(envList: Dictionary<String, String>, defaultEnv: String) {
        self.envList = envList
        if (envList[defaultEnv] != nil) {
            self.defaultEnv = envList[defaultEnv]
        } else {
            print(self.warning)
            self.defaultEnv = ""
        }
    }
    
    public func getEnv(env: String?) -> String {
        if var myEnv = self.defaultEnv {
            myEnv = self.defaultEnv!
            if (env != nil) {
                if (self.envList![env!] != nil) {
                    myEnv = self.envList![env!]!
                } else {
                    print(self.warning)
                    return ""
                }
            }
            
            return myEnv
        } else {
            print(self.warning)
            return ""
        }
    }
    
}
