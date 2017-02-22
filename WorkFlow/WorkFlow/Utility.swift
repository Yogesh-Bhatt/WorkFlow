//
//  Utility.swift
//  WorkFlow
//
//  Created by Yogesh Bhatt on 21/02/17.
//  Copyright © 2017 Yogesh Bhatt. All rights reserved.
//

import Foundation

enum Client {
    static let clientID = "5836f395acf3f0f975807d11_3rnd3q1v5y4gg8s4c88w0848g0gow00c8ggsgws0w00kgoc808"
    static let clientToken = "62erhw408yo0c4oc0480wwccc0cww44s4k4sg0c40s88gw4400"
}

class Utility: NSObject {
    
    class func saveAccessToken(deviceToken:String) {
        UserDefaults.standard.set(deviceToken, forKey: "AccessToken")
        UserDefaults.standard.synchronize()

    }
    
    class func getAccessToken() -> String{
        if UserDefaults.standard.string(forKey: "AccessToken") == nil {return ""}
        return UserDefaults.standard.string(forKey: "AccessToken")!

    }
    
    class func saveRefreshToken(client_id:String){
        
    }
    
    class func getRefreshToken(){
        
    }
    
    class func isUserRegistered() -> Bool{
        return UserDefaults.standard.bool(forKey: "UserRegistered")
        
    }
    
    class func registereUser(status:Bool) {
        
        UserDefaults.standard.set(status, forKey: "UserRegistered")
        UserDefaults.standard.synchronize()
        
    }
    
    
}
