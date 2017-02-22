//
//  WorkFlowApi.swift
//  WorkFlow
//
//  Created by Yogesh Bhatt on 21/02/17.
//  Copyright © 2017 Yogesh Bhatt. All rights reserved.
//

import Foundation

enum WorkFlowApi {
    
    static let BaseURL = "http://85.222.238.74/"
    
    
    static let Login = WorkFlowApi.BaseURL + "oauth/v2/token"
    static let Register = WorkFlowApi.BaseURL + "register"
    
    static let WorkFlowList = WorkFlowApi.BaseURL + "api/v1/workflows"
    static let CreateWorkFlow = WorkFlowApi.BaseURL + "api/v1/workflow"
    static let GetWorkFlow = WorkFlowApi.BaseURL + "api/v1/workflow"
    static let UpdateWorkFlow = WorkFlowApi.BaseURL + "api/v1/workflows/"
    static let DeleteWorkFlow = WorkFlowApi.BaseURL + "api/v1/workflows/"
}
