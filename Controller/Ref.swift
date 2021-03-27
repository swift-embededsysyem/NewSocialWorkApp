//
//  Ref.swift
//  newSocialApp
//
//  Created by akbar  Rizvi on 2/15/20.
//  Copyright © 2020 akbar  Rizvi. All rights reserved.
//

import Foundation
import Firebase

// these values will be stored in database
// if changed REF_USER to user instead of users
 let REF_USER = "user"
let REF_MESSAGE = "messages"
let REF_GEO = "Geolocs"
let REF_INBOX = "inbox"


class Ref {
    let databaseRoot: DatabaseReference = Database.database().reference()
  
    var databaseUsers: DatabaseReference {
        return databaseRoot.child(REF_USER)
}
 
    // creating database specific path
    func databaseSpecificUser(uid:String) -> DatabaseReference {
        return databaseRoot.child(uid)
    }
// creating a ref for messages
    
    var databaseMessage:DatabaseReference {
        return databaseRoot.child(REF_MESSAGE)
    }
    func databaseMessageSendTo(from:String, to:String) -> DatabaseReference {
        // path we want are messages to be stored
    
        return databaseMessage.child(from).child(to)
    }
    
    
    var databaseGeo: DatabaseReference{
        return databaseRoot.child(REF_GEO)
    }
// creating a reference for inbox messages
    var databaseInbox:DatabaseReference {
        return databaseRoot.child(REF_INBOX)
    }
    // creating a function for inbox messages send messages
    func databaseInboxInfor(from:String, to:String) -> DatabaseReference {
        return databaseInbox.child(from).child(to)
    }
    // creating a  method to retrive data path from inbox
      func databaseInboxForUser(uid: String) -> DatabaseReference {
         return databaseInbox.child(uid)
     }
}
