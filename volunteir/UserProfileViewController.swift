//
//  UserProfileViewController.swift
//  volunteir
//
//  Created by Arnav Kartikeya on 12/31/19.
//  Copyright © 2019 Arnav Kartikeya. All rights reserved.
//

import UIKit
import MBCircularProgressBar
import Firebase
class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var hoursProgress: MBCircularProgressBarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hoursProgress.value = 0
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        print("activated")
        let id = Auth.auth().currentUser?.uid
        let ref = Database.database().reference().child("users/\(id!)")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let hours = value!["hours"]
            print(hours)
            let hrs = hours as! Int
            self.hoursProgress.value = hours as! CGFloat
            if(hrs >= Int(self.hoursProgress.maxValue)){
                self.hoursProgress.maxValue = self.hoursProgress.maxValue + 25
                print(true)
                print(self.hoursProgress.maxValue)
            }
            UIView.animate(withDuration: 5.0){
                self.hoursProgress.value = hours as! CGFloat
            }
        })
    }

}
