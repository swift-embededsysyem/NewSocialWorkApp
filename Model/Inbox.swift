//
//  Inbox.swift
//  newSocialApp
//
//  Created by akbar  Rizvi on 6/13/20.
//  Copyright © 2020 akbar  Rizvi. All rights reserved.
//

import Foundation

class Inbox {
    
 
    var text: String
    var user: User
    
    
    
    init(text:String,user:User) {
     
        self.text = text
        self.user = user
    }
    

    
    static func transformInbox(dict: [String: Any],user: User) -> Inbox? {
           guard let text = dict["text"] as? String else {
                   return nil
           }
           let inbox = Inbox( text: text, user: user)
           return inbox
       }
    
}
