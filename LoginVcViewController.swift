
//  LoginVcViewController.swift
//  newSocialApp
//
//  Created by akbar  Rizvi on 10/14/19.
//  Copyright © 2019 akbar  Rizvi. All rights reserved.
//

import UIKit
import Firebase

class LoginVcViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func loginButtonPressed(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {(user,error)
                    in
                    
                    if user != nil
                    {
                         print("login sucessfull")
                        self.performSegue(withIdentifier: "goToSwipe", sender: self)
                        
                    }
                    else
                    {
                        let alert = UIAlertController(title:"Wrong Information", message: nil, preferredStyle: .alert)
                        let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
                        alert.addAction(okButton)
                        self.present(alert,animated: true,completion: nil)
                        print("login Failed")
                    }
                }
                
            }
        
           
        

    }

            

    

