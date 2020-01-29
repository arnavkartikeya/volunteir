//
//  PendingAdminsViewController.swift
//  volunteir
//
//  Created by Arnav Kartikeya on 1/27/20.
//  Copyright © 2020 Arnav Kartikeya. All rights reserved.
//

import UIKit
import Firebase
class PendingAdminsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var pendingAdmins = [String]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pendingAdmins.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             let cell = tableView.dequeueReusableCell(withIdentifier: "productstable", for: indexPath)
             cell.textLabel?.text = self.pendingAdmins[indexPath.row]
             return cell
       }
    

    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference()
        let user = ref.child("users")
        user.observe(.value) { (snapshot) in
              let enumerator = snapshot.children
              while let rest = enumerator.nextObject() as? DataSnapshot {
                  let r = rest.value as? NSDictionary
                if("\(r!["type"]!)" == "admin"){
                    if("\(r!["flag"]!)" == "0"){
                      let username = "\(r!["First name"]!)" + " \(r!["Last name"]!)"
                      self.pendingAdmins.append(username)
                      print(self.pendingAdmins)
                    }
              }
              self.tblView.reloadData()
        }

        // Do any additional setup after loading the view.
       }
       self.tblView.dataSource = self
        self.tblView.delegate = self
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
