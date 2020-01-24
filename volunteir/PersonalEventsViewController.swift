//
//  PersonalEventsViewController.swift
//  volunteir
//
//  Created by Arnav Kartikeya on 1/2/20.
//  Copyright © 2020 Arnav Kartikeya. All rights reserved.
//

import UIKit
import Firebase
class PersonalEvents{
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
class PersonalEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblEvents: UITableView!
    var yourArray = [String]()
    var actualEvents:[PersonalEvents] = []


    override func viewDidLoad() {
    super.viewDidLoad()
    yourArray = []
    actualEvents = []
    let id = Auth.auth().currentUser?.uid
    Database.database().reference().child("users").child(id!).child("registeredEvents").observe(.value) { snapshot in
          self.yourArray.removeAll()
          let children = snapshot.children
             while let rest = children.nextObject() as? DataSnapshot, let value = rest.value {
                print(value)
                  self.yourArray.append(value as! String)
              }
               Database.database().reference().child("Events").observe(.value) { (data) in
                    let events = data.value as! [String:[String:Any]]
                    for(_,value) in events{
                        if(self.yourArray.contains(value["EventName"]! as! String)){
                            self.actualEvents.append(PersonalEvents(evName: value["EventName"]! as! String, evDesc: value["EventDescription"]! as! String, evStartDate: value["start time"]! as! String, evEndDate: value["end time"] as! String, evNumPeople: value["NumberOfPeople"]! as! Int, evNumRegistered: value["currentPeople"] as! Int))
                           }
                        }
                        print("Actual events array " + "\(self.actualEvents)")
                  }
            self.tblEvents.reloadData()
        }
        print(yourArray)
        self.tblEvents.dataSource = self
        self.tblEvents.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yourArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productstable", for: indexPath)
        cell.textLabel?.text = self.yourArray[indexPath.row]
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let destination = segue.destination as? PersonalEventsInfoViewController {
               destination.personalEventInfo = actualEvents[(tblEvents.indexPathForSelectedRow?.row)!]
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
