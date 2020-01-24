//
//  EventContViewController.swift
//  volunteir
//
//  Created by Arnav Kartikeya on 12/27/19.
//  Copyright © 2019 Arnav Kartikeya. All rights reserved.
//

import UIKit
import Firebase

class EventContViewController: UIViewController {
    var eventName:String = ""
    var infoDict:[String:Any] = [:]
    var isFirst = true
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
        
    @IBOutlet weak var dateEndPicker: UIDatePicker!
    
    @IBOutlet weak var inputEndTextFeild: UITextField!
    
    let dateFormatter = DateFormatter()
        
    @IBOutlet weak var isCreated: UILabel!
    
    override func viewDidLoad() {
          super.viewDidLoad()
          // Do any additional setup after loading the view.
           isCreated.isHidden = true
          dateFormatter.dateFormat = "MM/dd/yyyy"
        
          inputTextField.inputView = datePicker
          datePicker.datePickerMode = .date
          inputTextField.text = dateFormatter.string(from: datePicker.date)
        
        inputEndTextFeild.inputView = dateEndPicker
        dateEndPicker.datePickerMode = .date
        inputEndTextFeild.text = dateFormatter.string(from: dateEndPicker.date)
      
      }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        if(isFirst == true){
            inputTextField.text = dateFormatter.string(from: sender.date)
            print(inputTextField.text!)
        }else{
            inputEndTextFeild.text = dateFormatter.string(from: sender.date)
            print(inputEndTextFeild.text!)
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
    
    @IBAction func firstConfirm(_ sender: Any) {
        isFirst = false
    }
    
    @IBAction func register(_ sender: Any) {
        print(eventName)
        infoDict["start time"] = inputTextField.text!
        infoDict["end time"] = inputEndTextFeild.text!
        infoDict["currentPeople"] = 0
        infoDict["admin"] = Auth.auth().currentUser?.uid
        let ref = Database.database().reference().child("Events").child(eventName)
        ref.setValue(infoDict)
        let id = Auth.auth().currentUser?.uid
        let db = Database.database().reference().child("users/\(id!)")
        db.child("createdEvents").child(eventName).setValue("\(eventName)")
        isCreated.isHidden = false
        performSegue(withIdentifier: "goToAdminAgain", sender: self)
    }
}
