//
//  AlamofireWrapper.swift
//  WorkFlow
//
//  Created by Yogesh Bhatt on 21/02/17.
//  Copyright © 2017 Yogesh Bhatt. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireManager {
    
    
    class func request(urlString : String, requestMethod : HTTPMethod, encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders? = nil, params : [String : Any]?, isLoginAPI: Bool = false, success:@escaping (AnyObject) -> Void, failure:@escaping (NSError) -> Void){
        
        Alamofire.request(urlString, method : requestMethod, parameters: params, encoding: encoding, headers: headers).responseJSON { (response) -> Void in
            
            switch response.result {
                
            case .success( _):
                
                if  response.response?.statusCode == 200
                {
                    success(response.result.value as AnyObject)
                    
                }
                else
                {
                    let error = NSError(domain: "ERROR",
                                        code: 100,
                                        userInfo: [NSLocalizedDescriptionKey: response.description])
                    
                    failure(error )
                }
                
                
            case .failure( _):
                failure(response.error as! NSError)
               break
                
            }
        }
    }
}
