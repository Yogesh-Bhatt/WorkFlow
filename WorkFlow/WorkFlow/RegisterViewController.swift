//
//  CreateWorkFlowViewController.swift
//  WorkFlow
//
//  Created by Yogesh Bhatt on 21/02/17.
//  Copyright © 2017 Yogesh Bhatt. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func createBtnClicked(_ sender: Any) {
        
        
       let paramDicitionary = ["name":txtName.text!, "username":txtUserName.text!, "email":txtEmail.text!, "plainPassword":txtPassword.text!]

        AlamofireManager.request(urlString: WorkFlowApi.Register, requestMethod: .put, params: paramDicitionary, success: { (object) in
            
            self.dismiss(animated: false) {
            }
            
        }) { (error) in
            
            let alert = UIAlertController(title: "Error", message: error.description, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension RegisterViewController:UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let nextTag = textField.tag + 1
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            // Have the next field become the first responder
            nextResponder.becomeFirstResponder()
            
        } else{
            textField.resignFirstResponder()
        }
        return false
    }
    
}
