//
//  inboxApi.swift
//  newSocialApp
//
//  Created by akbar  Rizvi on 6/17/20.
//  Copyright © 2020 akbar  Rizvi. All rights reserved.
//


import Foundation
import FirebaseAuth
import Firebase
// once the fuction is ove it reurn inbox
 typealias InboxCompletion = (Inbox) -> Void


class InBoxApi {
  // var user:User?
    // creating a function to retrive messages from inbox
    
    func lastMessages(uid:String, onSuccess: @escaping(InboxCompletion) ) {
        // creating a reference to retrive message
        let ref = Ref().databaseInboxForUser(uid:uid)
        ref.observe(DataEventType.childAdded) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, Any> {
               // print(dict)
                // now retrieve the partner id by retriving user id through firebase (partners UID)
                // problem could be rom here useinfor function
                Api.User.UserInfor(uid: snapshot.key, onSuccess: { (user) in
                    if let inbox = Inbox.transformInbox(dict: dict, user: user) {
                    onSuccess((inbox))
                    }
                    // print(inbox?.user)
                })
              }
          }
     }
 }

                // problem is creatin an instance of a user
                
// let user = User(uid:String,dictionary: Dictionary<String, AnyObject>)
    

                
                
                     
            
        
