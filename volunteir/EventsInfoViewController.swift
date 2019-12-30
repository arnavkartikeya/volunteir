//
//  EventsInfoViewController.swift
//  volunteir
//
//  Created by Arnav Kartikeya on 12/29/19.
//  Copyright © 2019 Arnav Kartikeya. All rights reserved.
//

import UIKit

class EventsInfoViewController: UIViewController {
    var eventInfo:Events?
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var eventStartDate: UILabel!
    @IBOutlet weak var eventDesc: UITextView!
    @IBOutlet weak var eventEndDate: UILabel!
    @IBOutlet weak var numPeople: UILabel!
    @IBOutlet weak var numRegister: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        eventLabel.text = "Event name: " + "\((eventInfo!.eventName)!)"
        eventDesc.text = "\((eventInfo!.eventDesc)!)"
        eventStartDate.text = "Start date: " + "\((eventInfo!.eventStartDate)!)"
        eventEndDate.text = "End date: " + "\((eventInfo!.eventEndDate)!)"
        numPeople.text = "Number of people needed: " + "\((eventInfo!.numPeople)!)"
        numRegister.text = "Number of people registered: " + "\((eventInfo!.numRegister)!)"
        // Do any additional setup after loading the view.
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
