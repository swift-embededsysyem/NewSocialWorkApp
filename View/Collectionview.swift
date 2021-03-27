//
//  UserCollecviewCollectionViewCell.swift
//  newSocialApp
//
//  Created by akbar  Rizvi on 12/21/19.
//  Copyright © 2019 akbar  Rizvi. All rights reserved.
//

import UIKit
import SDWebImage
// user did set method to get user objects such as objects such as user age , username and their picture(Avator) string by sdweb.
class Collectionview: UICollectionViewCell {
    
   var user:User!
    
    
  // creating an instance from a different class it a term in oop programing
    // var controller: HomeVc!
    
    @IBOutlet weak var avator: UIImageView!
    @IBOutlet weak var userNameTextField: UILabel!
    @IBOutlet weak var userAgeTextField: UILabel!
   
   
    func loadUser(_ user:User){
/*
        print(user.profileImageURL as Any)
     
         self.user = user
        
        let imageUrl = user.profileImageURL
        avator.loadImagee(imageUrl)
        
        let age = user.userAge
        self.userAgeTextField.text = age
        
        let name = user.userName
        self.userNameTextField.text = name
        */
        
         
         
         // real code
        guard let imageUrl = user.profileImageURL else { return }
       // avator.loadImagee(imageUrl)
        avator.sd_setImage(with: URL(string: imageUrl), placeholderImage:nil)
      //  Collectionview.downloadMoviePoster(path: imageUrl) { (recievedImage) in
          //  self.avator.image = recievedImage
            
       // }
      
       // if let age = user.userAge {
     //       self.userAgeTextField.text = age
     // r   } else {
            
       //     print("error")
    //    }
        if let age = user.userAge{
       // self.userAgeTextField.text = age
            self.userAgeTextField.text = age
        } else {
            print("error")
        }
        if let name = user.userName {
            self.userNameTextField.text = name
        } else {
            print("error")
        }
        
       // self.controller.collectionView.reloadData()
    
    }
    class func downloadMoviePoster(path:String ,onImage:@escaping ( _ image:UIImage?)-> Void) -> Void {
            
            if let imageURL = URL(string: path) {
                
                let task = URLSession.shared.dataTask(with: imageURL, completionHandler: { (data, response, error) in
                    
                    if error != nil {
                        return
                    }
                    if let imageData = data {
                        onImage(UIImage(data: imageData));
                    }
                    
                });
                task.resume();
            }
        }
}

