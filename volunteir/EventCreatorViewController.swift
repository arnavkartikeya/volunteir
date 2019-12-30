//
//  EventCreatorViewController.swift
//  volunteir
//
//  Created by Arnav Kartikeya on 12/26/19.
//  Copyright © 2019 Arnav Kartikeya. All rights reserved.
//

import UIKit
import Firebase
class EventCreatorViewController: UIViewController {
    var count = 0
    @IBOutlet weak var numPeople: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var eventName: UITextField!
    
    @IBAction func sliding(_ sender: UISlider) {
        numPeople.text = "Number of people: "+String(Int(sender.value))
        count = Int(sender.value)
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
