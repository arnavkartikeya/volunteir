//
//  EventsTableViewController.swift
//  volunteir
//
//  Created by Arnav Kartikeya on 12/29/19.
//  Copyright © 2019 Arnav Kartikeya. All rights reserved.
//

import UIKit
import Firebase
class Events{
    var eventName:String?
    var eventDesc:String?
    var eventStartDate:String?
    var eventEndDate:String?
    var numPeople:Int?
    var numRegister:Int?
    
    init(evName:String, evDesc:String, evStartDate:String, evEndDate:String, evNumPeople:Int, evNumRegistered:Int){
        self.eventName = evName
        self.eventDesc = evDesc
        self.eventStartDate = evStartDate
        self.eventEndDate = evEndDate
        self.numPeople = evNumPeople
        self.numRegister = evNumRegistered
    }
}
class EventsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var eventName = ""
    
    @IBOutlet weak var tblEvents: UITableView!
    var ref:DatabaseReference!
    var actualEvents:[Events] = []
    var eventsArray:[String] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productstable", for: indexPath)
        cell.textLabel?.text = self.eventsArray[indexPath.row]
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        ref.child("Events").observe(.value) { (data) in
            let events = data.value as! [String:[String:Any]]
            for(_,value) in events{
                if(self.eventsArray.contains(value["EventName"]! as! String) == false){
                    self.eventsArray.append(value["EventName"]! as! String)
                    self.actualEvents.append(Events(evName: value["EventName"]! as! String, evDesc: value["EventDescription"]! as! String, evStartDate: value["start time"]! as! String, evEndDate: value["end time"] as! String, evNumPeople: value["NumberOfPeople"]! as! Int, evNumRegistered: value["currentPeople"] as! Int))
                }
            }
            self.tblEvents.reloadData()
        }
        self.tblEvents.dataSource = self
        self.tblEvents.delegate = self
        
        
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        //Access the array that you have used to fill the tableViewCell
        print("tableView function: " + "\(eventsArray[indexPath.row])")
        eventName = eventsArray[indexPath.row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? EventsInfoViewController {
            destination.eventInfo = actualEvents[(tblEvents.indexPathForSelectedRow?.row)!]
            tblEvents.deselectRow(at: tblEvents.indexPathForSelectedRow!, animated: true)

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
