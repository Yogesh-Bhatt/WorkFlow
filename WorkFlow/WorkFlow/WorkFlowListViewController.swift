//
//  WorkFlowListViewController.swift
//  WorkFlow
//
//  Created by Yogesh Bhatt on 21/02/17.
//  Copyright © 2017 Yogesh Bhatt. All rights reserved.
//

import UIKit
import Alamofire

class WorkFlowListViewController: UIViewController {

    var workFlowArray = [WorkFlowModel]()
    var userName:String!
    var password:String!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        
        workFlowArray.removeAll()
        listOfWorkFlow()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true

        
        let createWorkFlow = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createWorkFlowButtonClicked))
        
        navigationItem.rightBarButtonItems = [createWorkFlow]
        
    }

    func listOfWorkFlow(){
        
        let parameters = ["grant_type":"password","client_id":Client.clientID,"client_secret":Client.clientToken,"username":userName,"password":password]
        
        let headers: HTTPHeaders = ["Authorization":"Bearer \(Utility.getAccessToken())"]
    
        Alamofire.request(WorkFlowApi.WorkFlowList, method: .get, parameters: parameters, headers: headers)
            .responseJSON { response in
                let array = response.result.value as! [[String:Any]]
            
                for obj in array {
                    
                guard let name = obj["name"], let stage = obj["stage"], let identifier = obj["identifier"]
                    else {
                        return
                    }
                    let workflowObj = WorkFlowModel(identifier: identifier as! String, name: name as! String, stage: stage as! String)
                    
                    self.workFlowArray.append(workflowObj)
                }
                
                self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createWorkFlowButtonClicked(){
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "CreateWorkFlowViewController") as! CreateWorkFlowViewController
        self.navigationController?.present(secondViewController, animated: true, completion: { 
            
        })
    }
    
    func deleteWorkFlow(identifier:String){
        let headers: HTTPHeaders = ["Authorization":"Bearer \(Utility.getAccessToken())"]
        
        let deleteURL = WorkFlowApi.DeleteWorkFlow
        Alamofire.request("\(deleteURL)\(identifier)", method: .delete, headers: headers)
            .responseJSON { response in
                debugPrint(response)
        }
    }
}

extension WorkFlowListViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workFlowArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkFlowList", for: indexPath)
        let workFlowObj = workFlowArray[indexPath.row]
        cell.textLabel?.text = workFlowObj.name
        cell.detailTextLabel?.text = workFlowObj.stage
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") {action in
            
            let workFlowObj = self.workFlowArray[indexPath.row]
            self.deleteWorkFlow(identifier: workFlowObj.identifier)

            self.workFlowArray.remove(at: indexPath.row)
            
            tableView.reloadData()

        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") {action in
            
        }
        
        return [deleteAction, editAction]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
