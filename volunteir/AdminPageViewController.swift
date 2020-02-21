//
//  AdminPageViewController.swift
//  volunteir
//
//  Created by Arnav Kartikeya on 2/20/20.
//  Copyright © 2020 Arnav Kartikeya. All rights reserved.
//

import UIKit
import Firebase
class AdminPageViewController: UIViewController {

    @IBOutlet weak var pending: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        pending.isHidden = true
        // Do any additional setup after loading the view.
    }
    

    @IBAction func pendingAdmins(_ sender: Any) {
        let ref = Database.database().reference()
        let id = Auth.auth().currentUser?.uid
        let user = ref.child("users").child(id!)
        user.observeSingleEvent(of: .value) { (snapshot) in
            let info = snapshot.value as! [String:Any]
            if(info["flag"] as! Int == 0){
                self.performSegue(withIdentifier: "goToPending", sender: self)
            }
            else{
                self.pending.isHidden = false
            }
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
