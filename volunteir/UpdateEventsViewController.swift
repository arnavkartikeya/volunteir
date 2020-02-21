//
//  UpdateEventsViewController.swift
//  volunteir
//
//  Created by Arnav Kartikeya on 2/10/20.
//  Copyright © 2020 Arnav Kartikeya. All rights reserved.
//

import UIKit
import Firebase
class UpdateEventsViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    var eventName:String = ""
    var currentValue:Int = 0
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var eventDescription: UITextView!
    
    lazy var desc = eventDescription.text!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.eventDescription.delegate = self
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           self.view.endEditing(true)
           return false
       }
       func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
           if(text == "\n") {
               textView.resignFirstResponder()
               return false
           }
           return true
       }
    

    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
         currentValue = Int(sender.value)
            
        label.text = "Number of people: "+"\(currentValue)"
    }
    
    
    
    @IBAction func didUpdate(_ sender: Any) {
        let ref = Database.database().reference()
        
        let eventChild = ref.child("Events")

    eventChild.child(eventName).child("NumberOfPeople").setValue(currentValue)
    eventChild.child(eventName).child("EventDescription").setValue(desc)
        

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              if let destination = segue.destination as? DateUpdateViewController {
               destination.eventName = eventName
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
