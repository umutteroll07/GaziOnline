//
//  ViewController.swift
//  GaziOnline
//
//  Created by Umut Erol on 1.03.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
    }


    @IBAction func clicked_studentEntry(_ sender: Any) {
        let signInViewController = self.storyboard?.instantiateViewController(identifier: "toSignViewController") as? SignInViewController
        self.navigationController?.pushViewController(signInViewController!, animated: true)
    }
    
    @IBAction func clicked_firmEntry(_ sender: Any) {
        let signInViewController = self.storyboard?.instantiateViewController(identifier: "toSignInFirmVC") as? SignInFirmViewController
        self.navigationController?.pushViewController(signInViewController!, animated: true)
    }
    
    
    @IBAction func clicked_lecturerEntry(_ sender: Any) {
        let signInViewController = self.storyboard?.instantiateViewController(identifier: "toSignInLecturerVC") as? SignInLecturerViewController
        self.navigationController?.pushViewController(signInViewController!, animated: true)
    }
    
    
}

