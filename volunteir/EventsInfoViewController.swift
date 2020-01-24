//
//  EventsInfoViewController.swift
//  volunteir
//
//  Created by Arnav Kartikeya on 12/29/19.
//  Copyright © 2019 Arnav Kartikeya. All rights reserved.
//

import UIKit
import Firebase
class EventsInfoViewController: UIViewController {
    var eventInfo:Events?
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var eventStartDate: UILabel!
    @IBOutlet weak var eventDesc: UITextView!
    @IBOutlet weak var eventEndDate: UILabel!
    @IBOutlet weak var numPeople: UILabel!
    @IBOutlet weak var numRegister: UILabel!
    @IBOutlet weak var registered: UILabel!
    @IBOutlet weak var registerError: UILabel!
    @IBOutlet weak var didRegister: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let id = Auth.auth().currentUser?.uid
        let ref = Database.database().reference().child("users/\(id!)/registeredEvents")
        registered.isHidden = true
        registerError.isHidden = true
        eventLabel.text = "Event name: " + "\((eventInfo!.eventName)!)"
        eventDesc.text = "\((eventInfo!.eventDesc)!)"
        eventStartDate.text = "Start date: " + "\((eventInfo!.eventStartDate)!)"
        eventEndDate.text = "End date: " + "\((eventInfo!.eventEndDate)!)"
        numPeople.text = "Number of people needed: " + "\((eventInfo!.numPeople)!)"
        numRegister.text = "Number of people registered: " + "\((eventInfo!.numRegister)!)"
        // Do any additional setup after loading the view.
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in

             if snapshot.hasChild("\((self.eventInfo!.eventName)!)"){
                print("already registered")
                self.registerError.isHidden = false
                self.didRegister.isHidden = true
              
             }else{
                 print("true")
            }
        })
    }
        
    @IBAction func didRegister(_ sender: Any) {
        registered.isHidden = true
        registerError.isHidden = true
              let id = Auth.auth().currentUser?.uid
              let ref = Database.database().reference().child("users/\(id!)/registeredEvents")
              ref.observeSingleEvent(of: .value, with: { (snapshot) in

                   if snapshot.hasChild("\((self.eventInfo!.eventName)!)"){
                      print("already registered")
                    self.registerError.isHidden = false
                    
                   }else{
                       print("true")
                    let ref = Database.database().reference().child("Events/\((self.eventInfo!.eventName)!)")
                           let db = Database.database().reference()
                           let event = db.child("Events")
                           ref.observeSingleEvent(of: .value, with: { (snapshot) in
                                 let value = snapshot.value as? NSDictionary
                                 let admin = value!["admin"] as! String
                                 var infoDict = ["EventDescription":((self.eventInfo!.eventDesc)!), "EventName":((self.eventInfo!.eventName)!), "NumberOfPeople":((self.eventInfo!.numPeople)!), "admin":admin, "start time": value!["start time"] as! String, "end time": value!["end time"] as! String, "currentPeople":value!["currentPeople"] as! Int + 1] as [String : Any]
                                 var username = Auth.auth().currentUser?.uid as! String
                                 event.child("\((self.eventInfo!.eventName)!)").setValue(infoDict)
                                   
                            let ad = db.child("users").child(admin)
                            ad.child("createdEvents").child("\(self.eventInfo!.eventName!)").child(username).setValue(username)
                            
                            
                               let user = db.child("users").child(username)
                            user.child("registeredEvents").child(self.eventInfo!.eventName!).setValue(self.eventInfo!.eventName!)
                                let userDB = Database.database().reference().child("users/\(username)")
                                userDB.observeSingleEvent(of: .value) { (snapshot) in
                                let value = snapshot.value as? NSDictionary
                                let hours = (value!["hours"])! as! Int
                                user.child("hours").setValue(hours+1)
                            }
                                self.eventInfo!.numRegister = self.eventInfo!.numRegister! + 1
                            self.numPeople.text = "Number of people needed: " + "\((self.eventInfo!.numPeople)!)"

                             })
                    self.registered.isHidden = false
                  }

        })
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
