//
//  MakeAdminViewController.swift
//  volunteir
//
//  Created by Arnav Kartikeya on 1/29/20.
//  Copyright © 2020 Arnav Kartikeya. All rights reserved.
//

import UIKit
import Firebase

class MakeAdminViewController: UIViewController {
    var name:MakeAdmin?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    
    @IBAction func makeAdmin(_ sender: Any) {
        let ref = Database.database().reference()
        print(name?.eventName!)
        let user = ref.child("users").child((name?.eventName!)!)
        user.child("flag").setValue(true);
        
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
