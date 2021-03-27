//
//  UserApi.swift
//  newSocialApp
//
//  Created by akbar  Rizvi on 6/12/20.
//  Copyright © 2020 akbar  Rizvi. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase

class UserApi {
    var currentUserId: String {
        return Auth.auth().currentUser != nil ? Auth.auth().currentUser!.uid : ""
    }
    /*
    func signIn(email: String, password: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authData, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            
            onSuccess()
        }
    }
    */
    func UserInfor(uid:String, onSuccess:@escaping(UserCompletion))  {
        let ref = Ref().databaseSpecificUser(uid: uid)
        ref.observe(.value) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, Any> {
                // if let user = User.transformUser(dict: dict) {
                   // onSuccess(user)
                }
            }
        
    }
        

        
       
    
    
    
}


    func getUserInforSingleEvent(uid: String, onSuccess: @escaping(UserCompletion)) {
        let ref = Ref().databaseSpecificUser(uid: uid)
        ref.observeSingleEvent(of: .value) { (snapshot) in
            if let dict = snapshot.value as? Dictionary<String, Any> {
//                if let user = User.transformUser(dict: dict) {
       //             onSuccess(user)
                }
            }
        }
   
typealias UserCompletion = (User) -> Void
