//
//  signupViewController.swift
//  newSocialApp
//
//  Created by akbar  Rizvi on 10/13/19.
//  Copyright © 2019 akbar  Rizvi. All rights reserved.
//


//  I have to use  find user method to bring the users to display on the screen.... 
import UIKit
import Firebase
import FirebaseDatabase
import GeoFire
import CoreLocation



class HomeVc: UIViewController {
    var users: [User] = []
   // var users =  [User]() // i tried this method i guess
 //   let mySlider = UISlider()
  //  let distanceLabel = UILabel()
  //  let manager = CLLocationManager()
  //  var userLat = ""
   // var userLong = ""
 //   var geoFire: GeoFire!
   // var geoFireRef: DatabaseReference!
 //   var myQuery: GFQuery!
   // var queryHandle: DatabaseHandle?
 //   var distance: Double = 500
   // var users: [User] = []
  //  var currentLocation: CLLocation?

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentLabel: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        fetchCurrentUserData()
       // configureLocationManager()
        collectionView.delegate = self
        collectionView.dataSource = self
       
        
        
        
    }
    /*
    func configureLocationManager() {
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = kCLDistanceFilterNone
        manager.pausesLocationUpdatesAutomatically = true
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            manager.startUpdatingLocation()
        }
        
        self.geoFireRef = Ref().databaseGeo
        self.geoFire = GeoFire(firebaseRef: self.geoFireRef)
    }
    */
    func fetchCurrentUserData() {
        
  guard  let currentUid = Auth.auth().currentUser?.uid else {return}
        
  
        
        
        // I was stuck my 6 days becuause of not going
    
  //  original code
    
    /*
     
     Database.database().reference().child("users").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in guard let dictionary = snapshot.value as? Dictionary<String , AnyObject> else {return}
      
     
     
    */
   
       // into the right root of the data base..

           Database.database().reference().child("users").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in guard let dictionary = snapshot.value as? Dictionary<String , AnyObject> else {return}
          //  print(snapshot.value as Any)
          //  print(snapshot)
          //  print(dictionary)
            
            for (key,value) in dictionary { // running a for loop issue was i was placing a dictionary within a dictionary
                print(key, value)
                
                guard let userValues = value as? Dictionary<String, AnyObject> else { //put break points and learn to do // // debugging
                   continue
                }
                
                let u = User(uid: key, dictionary: userValues) // user model
                if key != currentUid {
                self.users.append(u)
                    
                    print(u)
            }
              /*
                       if u.isMale == nil {
                                             return
                                         }
                                         switch self.segmentLabel.selectedSegmentIndex {
                                         case 0:
                                         if u.isMale! {
                                             self.users.append(u)
                                         }
                                         case 1:
                                            if !u.isMale! {
                                                self.users.append(u)
                                            }
                                         case 2:
                                             self.users.append(u)
                                         default:
                                             break
                                         }
 */
                self.collectionView.reloadData()
                   
            }
        
            //  self.collectionView.reloadData()
    
            }) { (error) in
                print(error.localizedDescription)
            }
   
    }
    
        /*
            
            if queryHandle != nil, myQuery != nil {
                myQuery?.removeObserver(withFirebaseHandle: queryHandle!)
                myQuery = nil
                queryHandle = nil
            }
            
            guard let userLat = UserDefaults.standard.value(forKey: "current_location_latitude") as? String, let userLong = UserDefaults.standard.value(forKey: "current_location_longitude") as? String else {
                return
            }
            
            let location: CLLocation = CLLocation(latitude: CLLocationDegrees(Double(userLat)!), longitude: CLLocationDegrees(Double(userLong)!))
            self.users.removeAll()
            
          //  myQuery = geoFire.query(at: location, withRadius: distance)
        myQuery = geoFire?.query(at: location, withRadius: distance)
           // queryHandle = myQuery.observe(GFEventType.keyEntered) { (key, location) in
        queryHandle = myQuery?.observe(.keyEntered, with: { (key, location)  in
            
            if key != Api.User.currentUserId {
                Api.User.getUserInforSingleEvent(uid: key, onSuccess: { (user) in
                    if self.users.contains(user) {
                        return
                    }
                    if user.isMale == nil {
                        return
                    }
                    switch self.segmentLabel.selectedSegmentIndex {
                    case 0:
                    if user.isMale! {
                        self.users.append(user)
                    }
                    case 1:
                    if !user.isMale! {
                        self.users.append(user)
                    }
                    case 2:
                        self.users.append(user)
                    default:
                        break
                    }
                    self.collectionView.reloadData()
                })
            }
        }
        )}
        
    */
        
    @IBAction func segmentOfGender(_ sender: UISegmentedControl) {
        
        fetchCurrentUserData()
    }
    
    // logOut user
    @IBAction func logOutButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        }
        catch let error {
            print(error)
        }
    }
    
    

}
extension HomeVc: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.users.count
      //  print(users.count)
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Collectionview", for: indexPath) as! Collectionview
        
      // cell.users = users[indexPath]
       // cell.loadUser(users)
        //   let user = users[indexPath.item]
        // using the function from the other clsss by defining controller.
       // cell.controller = self
       // cell.user = users[indexPath.item]
       // cell.loadUser()
        // cell.user = users[indexPath.item]
        // controlling

          let user = users[indexPath.item]
        
               //cell.controller = self
        
           cell.loadUser(user)
           //    cell.loadUser(user)
       // self.collectionView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        if let cell = collectionView.cellForItem(at: indexPath) as? Collectionview {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let chatVC = storyboard.instantiateViewController(withIdentifier: "gotoMessage") as! chatViewController
            chatVC.imagePartner = cell.avator.image
            chatVC.partnerUsername = cell.userNameTextField.text
            chatVC.partnerId = cell.user.uid! // id of the partner  user
            chatVC.partnerUser = cell.user
            // we probbably dont use partner user
           // self.navigationController?.pushViewController(chatVC, animated: true)
            present(chatVC, animated: true, completion: nil)
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width/3 - 2, height: view.frame.size.width/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
        
    }
    
    
}
/*
extension HomeVc: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedAlways) || (status == .authorizedWhenInUse) {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       // ProgressHUD.showError("\(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        manager.delegate = nil
        let updatedLocation: CLLocation = locations.first!
        let newCoordinate: CLLocationCoordinate2D = updatedLocation.coordinate
        self.currentLocation = updatedLocation
        // update location
        let userDefaults: UserDefaults = UserDefaults.standard
        userDefaults.set("\(newCoordinate.latitude)", forKey: "current_location_latitude")
        userDefaults.set("\(newCoordinate.longitude)", forKey: "current_location_longitude")
        userDefaults.synchronize()
        
        if let userLat = UserDefaults.standard.value(forKey: "current_location_latitude") as? String, let userLong = UserDefaults.standard.value(forKey: "current_location_longitude") as? String {
            let location: CLLocation = CLLocation(latitude: CLLocationDegrees(Double(userLat)!), longitude: CLLocationDegrees(Double(userLong)!))
            /*
            Ref().databaseSpecificUser(uid: Api.User.currentUserId).updateChildValues([userLat: userLat, userLong: userLong])
            self.geoFire?.setLocation(location, forKey: Api.User.currentUserId) { (error) in
                if error == nil {
                    // Find Users
                    self.fetchCurrentUserData()
                }
            }
 */
        }
        
        print(users.count)

    }
    
}
*/

