//
//  user.swift
//  newSocialApp
//
//  Created by akbar  Rizvi on 10/22/19.
//  Copyright © 2019 akbar  Rizvi. All rights reserved.
//

import Foundation
import UIKit
import Firebase



 
    class User {
        
       // attributes getting users info so i can set up from firebase
     
        var userName:String!
        var userAge:String!
        var uid: String!
        var profileImageURL:String!
        var isMale:Bool?
        
        
        init (uid:String,dictionary:Dictionary<String,AnyObject>){
            
            self.uid = uid
            if let userName = dictionary["userName"] as? String {
                self.userName = userName
            }
            
            if let userAge = dictionary["userAge"] as? String {
                self.userAge = userAge
            }
            
            if let profileImageURL = dictionary["profileImageURL"] as? String {
                self.profileImageURL = profileImageURL
            }
            
        }
        
        
        
    }

