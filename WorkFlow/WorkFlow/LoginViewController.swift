//
//  LoginViewController.swift
//  WorkFlow
//
//  Created by Yogesh Bhatt on 21/02/17.
//  Copyright © 2017 Yogesh Bhatt. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txtLogin: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginBtnClicked(_ sender: Any) {
        
        let paramDicitionary = ["grant_type":"password","client_id":Client.clientID,"client_secret":Client.clientToken,"username":txtLogin.text!,"password":txtPassword.text!]
                
        AlamofireManager.request(urlString: WorkFlowApi.Login, requestMethod: .post, params: paramDicitionary, success: { (object) in
            

            if let tokenString = object.value(forKey: "access_token")  {
                Utility.saveAccessToken(deviceToken: tokenString as! String)
            }
            
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let workFlowViewController = storyBoard.instantiateViewController(withIdentifier: "WorkFlowListViewController") as!WorkFlowListViewController
            workFlowViewController.userName = self.txtLogin.text!
            workFlowViewController.password = self.txtPassword.text!
            
            self.navigationController?.pushViewController(workFlowViewController, animated: true)
            
        }) { (error) in
            
            print(error)
            
        }

    }

}

extension LoginViewController:UITextFieldDelegate {
    
    
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

