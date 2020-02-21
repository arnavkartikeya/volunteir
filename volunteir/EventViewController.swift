//
//  EventViewController.swift
//  volunteir
//
//  Created by Arnav Kartikeya on 12/26/19.
//  Copyright © 2019 Arnav Kartikeya. All rights reserved.
//

import UIKit
import Firebase
class EventViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate{
    var currentValue:Int = 0
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var eventName: UITextField!
    @IBOutlet weak var eventDesc: UITextView!
    
    lazy var desc = eventDesc.text!
    
    var infoDict:[String:Any] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.eventName.delegate = self
        self.eventDesc.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
         currentValue = Int(sender.value)
            
        label.text = "Number of people: "+"\(currentValue)"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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
    @IBAction func eventCreated(_ sender: Any) {
        let ref = Database.database().reference()
        let eventChild = ref.child("Events")
        infoDict = ["EventName" : eventName.text!, "NumberOfPeople" : currentValue, "EventDescription": desc] as [String : Any]
        eventChild.child(eventName.text!).setValue(infoDict)
        performSegue(withIdentifier: "eventContinue", sender: self)
    }
    func convertDateFormatter() -> String {
         let date = Date()
         let formatter = DateFormatter()
         formatter.dateFormat = "MM-dd-yyyy" // change format as per needs
         let result = formatter.string(from: date)
         return result
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "eventContinue" {
            let vc = segue.destination as! EventContViewController
            vc.infoDict = infoDict
            vc.eventName = eventName.text!
            print(vc.eventName)
        }

    }
}
