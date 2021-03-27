//
//  MessageApi.swift
//  newSocialApp
//
//  Created by akbar  Rizvi on 2/15/20.
//  Copyright © 2020 akbar  Rizvi. All rights reserved.
//

import Foundation
import Firebase

class MessageApi {
    
    func sendMessage(from: String, to: String, value: Dictionary<String, Any>) {
    
        
        let ref = Ref().databaseMessageSendTo(from:from, to: to)
        ref.childByAutoId().updateChildValues(value)
        
        var dict = value  
        if let text = dict["text"] as? String, text.isEmpty {
            dict["imageUrl"] = nil
            dict["height"] = nil
            dict["width"] = nil
        }
        
 // retrive inbox send messages
        let refFrom = Ref().databaseInboxInfor(from: from, to: to)
        refFrom.updateChildValues(value)
        // update partner messages
        let refTo = Ref().databaseInboxInfor(from: to, to: from)
        refTo.updateChildValues(value)
        
    }
    
    
    
    // here we will create a bussiness logic of the method
    func recieveMessage(from:String, to:String,onSuccess: @escaping(Message) -> Void) {
        // here we are observing new messages
        let ref = Ref().databaseMessageSendTo(from: from, to: to)
        
        ref.observe(.childAdded) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String,Any> {
                if let message = Message.transformMessage(dict: dict, keyId: snapshot.key) {
                    onSuccess(message)
                }

                print(dict)
            }
            
        }
        
    }

}
