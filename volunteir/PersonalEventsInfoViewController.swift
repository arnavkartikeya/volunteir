//
//  PersonalEventsInfoViewController.swift
//  volunteir
//
//  Created by Arnav Kartikeya on 1/4/20.
//  Copyright © 2020 Arnav Kartikeya. All rights reserved.
//

import UIKit
import Firebase
class PersonalEventsInfoViewController: UIViewController {
    var personalEventInfo:PersonalEvents?
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var eventStartDate: UILabel!
    @IBOutlet weak var eventDesc: UITextView!
    @IBOutlet weak var eventEndDate: UILabel!
    @IBOutlet weak var numPeople: UILabel!
    @IBOutlet weak var numRegister: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        eventLabel.text = "Event name: " + "\((personalEventInfo!.eventName)!)"
        eventDesc.text = "\((personalEventInfo!.eventDesc)!)"
        eventStartDate.text = "Start date: " + "\((personalEventInfo!.eventStartDate)!)"
        eventEndDate.text = "End date: " + "\((personalEventInfo!.eventEndDate)!)"
        numPeople.text = "Number of people needed: " + "\((personalEventInfo!.numPeople)!)"
        numRegister.text = "Number of people registered: " + "\((personalEventInfo!.numRegister)!)"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didUnregister(_ sender: Any) {
        let id = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        ref.child("users").child(id!).child("registeredEvents").child(personalEventInfo!.eventName!).removeValue { error,arg  in
          if error != nil {
              print("error \(error)")
          }
        }
        ref.child("users").child(id!).child("hours").observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as! Int
            Database.database().reference().child("users").child(id!).child("hours").setValue(value  - 1)
        }
        let event = ref.child("Events")
        event.child(personalEventInfo!.eventName!).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as! NSDictionary
            var currentPeople = value["currentPeople"] as! Int
            currentPeople = currentPeople - 1
        Database.database().reference().child("Events").child(self.personalEventInfo!.eventName!).child("currentPeople").setValue(currentPeople)
        }
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
