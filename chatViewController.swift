//
//  chatViewController.swift
//  newSocialApp
//
//  Created by akbar  Rizvi on 1/15/20.
//  Copyright © 2020 akbar  Rizvi. All rights reserved.
//

import UIKit
import Firebase

class chatViewController: UIViewController {
    var messages = [Message]()
    var partnerUsername: String!
    var partnerId: String!
    var partnerUser: User!
    var imagePartner: UIImage!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sendButtonPressed: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

      
        observeMessages()
        tableView.delegate = self
        tableView.dataSource = self
     //    self.tableView.reloadData()
          tableView.separatorStyle = .none
  
        tableView.tableFooterView = UIView()
    }
    

   
    
    func sendToFireBase(dict: Dictionary<String,Any>) {
      
        var value = dict
        value["from"] = Auth.auth().currentUser!.uid
        value["to"] = partnerId
        
        
        //adding the code to push the message to the database
        
        Api.Message.sendMessage(from: Auth.auth().currentUser!.uid, to: partnerId!, value: value)
        
        
        
        
    }
    
    
    
   
    @IBAction func sendButtonPressedd(_ sender: UIButton) {
        
       // first we will make sure that the text field is not empty and then we will send the message
        
        if let text = messageTextView.text, text != "" {
            messageTextView.text = ""
         
            sendToFireBase(dict: ["text":text as Any])
        }
   
    
    
}
    // i need to create message transform method that can change the dictionary value into String.
    // and create a trailing closure
    //
    
    func observeMessages() {
        
        // here we will call the function to observe messages
        
        // in here we will call both current user id and the partner id and recieve their messages through partner id & current uid
        Api.Message.recieveMessage(from: Auth.auth().currentUser!.uid, to: partnerId!)
        { (message) in
        self.messages.append(message)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
           
     }
        Api.Message.recieveMessage(from: partnerId ?? "", to: Auth.auth().currentUser!.uid)
    { (message) in
            self.messages.append(message)
             DispatchQueue.main.async {
                self.tableView.reloadData()
             }
            
        }
    
     
        // after that we have to retrieve the data from the database
        
 
        
        
    }

}
extension chatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ChatTableViewCell
       
        cell.configureCell(uid: Auth.auth().currentUser!.uid, message: messages[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 0
        let message = messages[indexPath.row]
        let text = message.text
        if !text.isEmpty {
            height = text.estimateFrameForText(text).height + 60
        }
        
        let heightMessage = message.height
        let widthMessage = message.width
        if heightMessage != 0, widthMessage != 0 {
            height = CGFloat(heightMessage / widthMessage * 250)
        }
        return height
    }
    
}


