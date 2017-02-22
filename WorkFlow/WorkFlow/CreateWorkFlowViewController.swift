//
//  ViewController.swift
//  WorkFlow
//
//  Created by Yogesh Bhatt on 21/02/17.
//  Copyright © 2017 Yogesh Bhatt. All rights reserved.
//

import UIKit
import Alamofire

enum StageType:String{
    case Hired = "Hired"
    case NotHired = "Not Hired"
    case InProgress = "In Progress"
}

class CreateWorkFlowViewController: UIViewController, SSRadioButtonControllerDelegate {
    @IBOutlet weak var hired: SSRadioButton!
    @IBOutlet weak var notHired: SSRadioButton!
    @IBOutlet weak var inProgress: SSRadioButton!
    @IBOutlet weak var txtName: UITextField!
    
    var radioButtonController: SSRadioButtonsController?

    var parameter = [String:String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        radioButtonController = SSRadioButtonsController(buttons: hired, notHired, inProgress)
        radioButtonController!.delegate = self
        radioButtonController!.shouldLetDeSelect = true
        
    }
    
    @IBAction func inProgressClicked(_ sender: Any) {
        parameter["stage"] = StageType.InProgress.rawValue
    }
    
    @IBAction func notHiredClicked(_ sender: Any) {
        parameter["stage"] = StageType.NotHired.rawValue

    }
    
    @IBAction func hiredButtonClicked(_ sender: Any) {
        parameter["stage"] = StageType.Hired.rawValue

    }
   
    
    @IBAction func createButtonClicked(_ sender: Any) {
                
        parameter["name"] = txtName.text
        
        let headers: HTTPHeaders = ["Authorization":"Bearer \(Utility.getAccessToken())"]
        
        AlamofireManager.request(urlString: WorkFlowApi.CreateWorkFlow, requestMethod: .put, headers: headers, params: parameter, success: { (object) in
            debugPrint(object)
            self.dismiss(animated: true, completion: { 
                
            })
        }) { (error) in
            
        }
      }

    @IBAction func cancelButtonClicked(_ sender: Any) {
        
        self.dismiss(animated: true) {
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

