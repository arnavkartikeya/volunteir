//
//  LoginViewController.swift
//  volunteir
//
//  Created by Arnav Kartikeya on 12/23/19.
//  Copyright © 2019 Arnav Kartikeya. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var invalidError: UILabel!
    var userKey:String = ""
    
    @IBOutlet weak var adminPermission: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        invalidError.isHidden = true
        adminPermission.isHidden = true
        self.email.delegate = self
        self.password.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    @IBAction func loginPressed(_ sender: Any) {
        adminPermission.isHidden = true
        invalidError.isHidden = true
        var success = true
        var type = "test"
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) {
                (user, error) in
                if(error != nil){
                    print(error!)
                    success = false
                    self.invalidError.isHidden = false
                }
                else{
                    
                    
                    print("success")
                    
                    let id = Auth.auth().currentUser?.uid
                    let ref = Database.database().reference().child("users/\(id!)")
                    print(ref)
                     ref.observeSingleEvent(of: .value, with: { (snapshot) in
                     let value = snapshot.value as? NSDictionary
                     type = (value!["type"])! as! String
                    if(type == "user"){
                        self.performSegue(withIdentifier: "goToUser", sender: self)
                        }
                        else{
                            let flag = value!["flag"] as! Bool
                            if(flag){
                                 self.performSegue(withIdentifier: "goToAdmin", sender: self)
                            }else{
                                self.adminPermission.isHidden = false
                            }
                        }
                      })
                       { (error) in
                        print(error.localizedDescription)
                    }
                    
                    
                    
                }
        }
    
    }
}
