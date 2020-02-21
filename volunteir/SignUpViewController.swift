//
//  SignUpViewController.swift
//  volunteir
//
//  Created by Arnav Kartikeya on 12/23/19.
//  Copyright © 2019 Arnav Kartikeya. All rights reserved.
//

import UIKit
import Firebase
class SignUpViewController: UIViewController, UITextFieldDelegate {
    var infoDict:[String:Any] = [:]
    var users:DatabaseReference!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repeatPass: UITextField!
    @IBOutlet weak var toSmallError: UILabel!
    @IBOutlet weak var doNotMatchError: UILabel!
    lazy var username = "\(firstName.text!)\(lastName.text!)"
    lazy var passWord = password.text
    lazy var eMail = email.text
    @IBOutlet weak var inUseError: UILabel!
    
    @IBOutlet weak var invalidEmailError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        toSmallError.isHidden = true
        doNotMatchError.isHidden = true
        inUseError.isHidden = true
        invalidEmailError.isHidden = true
        
        repeatPass.delegate = self
        
        self.firstName.delegate = self
        self.lastName.delegate = self
        self.email.delegate = self
        self.password.delegate = self
    }
    
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func didRegister(_ sender: Any) {
                    self.toSmallError.isHidden = true
                    self.doNotMatchError.isHidden = true
                    self.inUseError.isHidden = true
                    self.invalidEmailError.isHidden = true
                    self.passWord = self.password.text
                    self.eMail = self.email.text!
                    if(self.repeatPass.text! == self.passWord){
                        Auth.auth().createUser(withEmail: self.eMail!, password: self.passWord!) {
                            (user, error) in
                            if(error != nil){
                                
                                if let errCode = AuthErrorCode(rawValue: error!._code) {
                                    switch errCode {
                                    case .invalidEmail:
                                        print("invalid email")
                                    self.invalidEmailError.isHidden = false
                                    case .emailAlreadyInUse:
                                        print("in use")
                                        self.inUseError.isHidden = false
                                    default:
                                        print("Other error!")
                                    }

                                }
                                
                                if(self.passWord!.count < 6){
                                    self.toSmallError.isHidden = false
                                }
                            }
                            else{
                                self.toSmallError.isHidden = true
                                self.doNotMatchError.isHidden = true
                                print("Registration succesful!")
                                self.pushUserInfo()
                                self.performSegue(withIdentifier: "registerSuccess", sender: self)
                            }
                        }
                    }else{
                        self.doNotMatchError.isHidden = false
                    }
    }
    
    func pushUserInfo(){
        let ref = Database.database().reference()
//        let users = ref.child("users")
//        let first = users.child(username).child("first name")
//        first.setValue(firstName.text)
//        let last = users.child(username).child("last name")
//        last.setValue(lastName.text)
//        let hours = users.child(username).child("hours")
//        hours.setValue(0)
//        let isUser = users.child(username).child("type")
//        isUser.setValue("user")
        
        infoDict = ["First name": firstName.text!, "Last name": lastName.text!, "hours": 0, "type" : "user"] as [String : Any]
        let id = Auth.auth().currentUser?.uid
        users = ref.child("users").child(id!)
        users.setValue(infoDict)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "registerSuccess" {
            let vc = segue.destination as! SignUpContViewController
            vc.stringHolder = username
            vc.infoDict = infoDict
            vc.userID = users.key!
        }

    }
}
