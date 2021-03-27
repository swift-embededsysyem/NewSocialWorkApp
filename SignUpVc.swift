//
//  ViewController.swift
//  newSocialApp
//
//  Created by akbar  Rizvi on 9/15/19.
//  Copyright © 2019 akbar  Rizvi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import CoreLocation
import GeoFire




class SignUpVc: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var loginPop: UIButton!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userAge: UITextField!
    @IBOutlet weak var genderSelect: UISegmentedControl!
    // creating an instance of cl location manager.
    let manager = CLLocationManager()
    var userLat = ""
    var userLong = ""
    var user:User?
    var geoFire: GeoFire!
    var geoFireRef: DatabaseReference! // geofire reference 
    

    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserlocation()
    }

    func  getUserlocation() {
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter  = kCLDistanceFilterNone
        manager.pausesLocationUpdatesAutomatically = true
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == .authorizedAlways) || (status == .authorizedWhenInUse) {
            manager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let updateLocation:CLLocation = locations.first!
        let newCoordinate:CLLocationCoordinate2D = updateLocation.coordinate
        print(newCoordinate.latitude)
        print(newCoordinate.longitude)
        // using user defaults to save user  location
        let userDefaults: UserDefaults = UserDefaults.standard
        userDefaults.set("\(newCoordinate.latitude)", forKey: "current_location_latitude")
        userDefaults.set("\(newCoordinate.longitude)", forKey: "current_location_longitude")
        userDefaults.synchronize()

    }
    
    @IBAction func signupButton(_ sender: Any) {
        print("hit/(signupButton)")
        guard  let userIDD = Auth.auth().currentUser?.uid else
        { return }// get user current user id
 
        // send to firebase
         if let userLat = UserDefaults.standard.value(forKey:"current_location_latitude") as? String, let userLong = UserDefaults.standard.value(forKey: "current_location_longitude") as? String {
                   self.userLat = userLat
                   self.userLong = userLong
            if !self.userLat.isEmpty && !self.userLong.isEmpty {
                           let location: CLLocation = CLLocation(latitude: CLLocationDegrees(Double(self.userLat)!), longitude: CLLocationDegrees(Double(self.userLong)!))
                self.geoFireRef = Ref().databaseGeo
                self.geoFire    = GeoFire(firebaseRef:self.geoFireRef)
                self.geoFire.setLocation(location, forKey: userIDD )
        }
        Auth.auth() .createUser(withEmail: emailTextField!.text!, password: passwordTextField!.text!) {(user,error)
            in
            if user != nil
            {
                self.performSegue(withIdentifier: "goToHome", sender: self)
                print("SignUp Sucessfull")
            }
            else {
                print("unSucessfull")
                // uiAlert
                let alert = UIAlertController(title:"wrong Information", message: nil, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "ok", style: .default, handler: nil)
                alert.addAction(okButton)
                self.present(alert,animated: true,completion: nil)
                print("login Failed")
            }
            // storing user data variables
      
            guard let userName = self.userName.text,!userName.isEmpty else {
                print("Email is Empty");return
            }
            guard let userAge = self.userAge.text,!userAge.isEmpty else {
                print("Age is required"); return
            }
           
            
            if self.genderSelect.selectedSegmentIndex == 0 {
                self.user?.isMale = true
            }
            
            if self.genderSelect.selectedSegmentIndex == 1 {
                self.user?.isMale = false
            }
   
            
            // upload image to firebase
            guard let profileImage = self.myImage.image else {return}
            
            guard let uploadData  =  profileImage.jpegData(compressionQuality:0.3) else {return}
            let filename = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child("profile_images").child(filename)
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            storageRef.putData(uploadData, metadata: metadata, completion: { (metaData, error) in
                
                
                if let  error = error {
                    
                    // alert notification
                    
                    print("failed to Upload image",error.localizedDescription)
                    return
                }
                
                // retrieve download url
                
                storageRef.downloadURL(completion: { (downloadURL, error) in
                    guard let profileImageURL = downloadURL?.absoluteString else {
                        print("DEBUG: Profile image url is nil")
                        return
                        
                    }
                    // storing variables into the dictionary **
                    print(profileImageURL)
                    /*
                    let userID = Auth.auth().currentUser?.uid // get user current user id
                    // user data dictionary
                 //   var dict = Dictionary<String, Any>()
                    
                    let userData = ["userName":userName,
                                    "userAge":userAge,"profileImageURL":profileImageURL] as [String? : Any]
                    */
                    let userID = Auth.auth().currentUser?.uid // get user current user id
                           var dict = Dictionary<String, Any>()
                    if let userName = self.userName.text, !userName.isEmpty {
                               dict["userName"] = userName
                           }
                    if let userAge = self.userAge.text, !userAge.isEmpty {
                               dict["userAge"] = userAge
                           }
                        
                    if self.genderSelect.selectedSegmentIndex == 0 {
                               dict["isMale"] = true
                           }
                    if self.genderSelect.selectedSegmentIndex == 1 {
                               dict["isMale"] = false
                           }
                          
                               dict["profileImageURL"] = profileImageURL
                           
                           
                    
                    let ref = Database.database().reference() // firebase documentation
                    
                    ref.child("users/\(userID ?? "")").setValue(dict)
                })
                
                
            })
            
        }
        
        
    }
    
    }
    // camera
@IBAction func imagePicker(_ sender: Any) {
let imageController = UIImagePickerController()
imageController.sourceType = UIImagePickerController.SourceType.photoLibrary
imageController.delegate = self
imageController.allowsEditing = false
self.present(imageController,animated: true,completion:nil)
        
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        myImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
}
}


