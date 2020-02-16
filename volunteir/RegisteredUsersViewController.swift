//
//  RegisteredUsersViewController.swift
//  volunteir
//
//  Created by Arnav Kartikeya on 1/15/20.
//  Copyright © 2020 Arnav Kartikeya. All rights reserved.
//

import UIKit
import Firebase
class RegisteredUsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    



    var events:AdminEvents?
    var registeredUsers = [String]()
    var actualUsers = [String]()
    @IBOutlet weak var tblView: UITableView!
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return actualUsers.count
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "productstable", for: indexPath)
          cell.textLabel?.text = self.actualUsers[indexPath.row]
          return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let id = Auth.auth().currentUser?.uid
    Database.database().reference().child("users").child(id!).child("createdEvents").child((events?.eventName!)!).observe(.value) { (snapshot) in
            print("start")
            print(snapshot.childrenCount)
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? DataSnapshot {
                self.registeredUsers.append(rest.key)
            }
            Database.database().reference().child("users").observe(.value) { (snapshot) in
                let enumerator = snapshot.children
                while let rest = enumerator.nextObject() as? DataSnapshot {
                    if(self.registeredUsers.contains(rest.key)){
                        //print(rest.value)
                        let r = rest.value as? NSDictionary
                        let username = "\(r!["First name"]!)" + " \(r!["Last name"]!)"
                        self.actualUsers.append(username)
                        print("Username" + "\(username)")
                        print(self.actualUsers)
                    }
                }
              self.tblView.reloadData()
          }
        }
        print("array")
        print(registeredUsers)

        // Do any additional setup after loading the view.
        self.tblView.dataSource = self
        self.tblView.delegate = self
 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let destination = segue.destination as? UpdateEventsViewController {
            destination.eventName = events!.eventName! 
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
