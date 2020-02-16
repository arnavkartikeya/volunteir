//
//  AdminsEventsViewController.swift
//  volunteir
//
//  Created by Arnav Kartikeya on 1/5/20.
//  Copyright © 2020 Arnav Kartikeya. All rights reserved.
//

import UIKit
import Firebase
class AdminEvents{
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

class AdminsEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var eventsArray = [String]()
    var actualEvents:[AdminEvents] = []

    
    

    @IBOutlet weak var tblEvents: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let id = Auth.auth().currentUser?.uid
         Database.database().reference().child("users").child(id!).child("createdEvents").observe(.value) { snapshot in
                 //self.eventsArray.removeAll()
               print("start")
               print(snapshot.childrenCount)
               let enumerator = snapshot.children
               while let rest = enumerator.nextObject() as? DataSnapshot {
                   self.eventsArray.append(rest.key as! String)
               }
                      Database.database().reference().child("Events").observe(.value) { (data) in
                           let events = data.value as! [String:[String:Any]]
                           for(_,value) in events{
                               print(self.eventsArray)
                               if(self.eventsArray.contains(value["EventName"]! as! String)){
                                   self.actualEvents.append(AdminEvents(evName: value["EventName"]! as! String, evDesc: value["EventDescription"]! as! String, evStartDate: value["start time"]! as! String, evEndDate: value["end time"] as! String, evNumPeople: value["NumberOfPeople"]! as! Int, evNumRegistered: value["currentPeople"] as! Int))
                                  }
                               }
                               print("Actual events array " + "\(self.actualEvents)")
                         }
                       self.tblEvents.reloadData()
                   }
                  self.tblEvents.dataSource = self
                  self.tblEvents.delegate = self

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count: "  + "\(eventsArray.count)")
          return eventsArray.count
      }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "productstable", for: indexPath)
          cell.textLabel?.text = self.eventsArray[indexPath.row]
          return cell
      }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RegisteredUsersViewController, let cell = sender as? UITableViewCell, let indexPath = tblEvents.indexPath(for:cell) {
               destination.events = actualEvents[indexPath.row]
               tblEvents.deselectRow(at: indexPath, animated: true)
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
