//
//  SignUpContViewController.swift
//  volunteir
//
//  Created by Arnav Kartikeya on 12/24/19.
//  Copyright © 2019 Arnav Kartikeya. All rights reserved.
//

import UIKit
import Firebase
class SignUpContViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var stringHolder:String = ""
    var infoDict:[String:Any] = [:]
    var userID:String = ""
    @IBOutlet weak var location: UIPickerView!
    let cities = ["Cupertino", "Mountain view", "Santa Clara", "San Jose", "Fremont", "Saratoga"]
    let types = ["technology", "dancing", "arts and crafts"]
    var selection:String! 
    @IBOutlet weak var selectedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        location.delegate = self
        location.dataSource = self
       
        // Do any additional setup after loading the view.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selection = cities[row]
        selectedLabel.text = "You selected: " + selection
        return cities[row]
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
            let username = stringHolder
            let id = Auth.auth().currentUser?.uid
            let ref = Database.database().reference()
            let users = ref.child("users").child(id!)
            infoDict["location"] = selection
            users.setValue(infoDict)
            print("registration successful")
            print(userID)
            performSegue(withIdentifier: "signUpSuccess", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "registerSuccess" {
            let vc = segue.destination as! LoginViewController
        }
    }
}
