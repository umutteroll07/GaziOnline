//
//  SideMenuFirmViewController.swift
//  GaziOnline
//
//  Created by Umut Erol on 13.03.2024.
//

import UIKit

class SideMenuFirmViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    
    @IBAction func clicked_homePage(_ sender: Any) {
        performSegue(withIdentifier: "toHomePageFirm", sender: nil)
    }
    
    @IBAction func clicked_students(_ sender: Any) {
        performSegue(withIdentifier: "toStudentsFirm", sender: nil)
    }
    
    
    @IBAction func clicked_adverts(_ sender: Any) {
        performSegue(withIdentifier: "toAdvertsFirmVC", sender: nil)
    }
    
    @IBAction func clicked_forms(_ sender: Any) {
        performSegue(withIdentifier: "toFormFirmVC", sender: nil)
    }
    
    @IBAction func clicked_surveys(_ sender: Any) {
        performSegue(withIdentifier: "toSurveyFirmVC", sender: nil)
    }
    
    @IBAction func clicked_logOut(_ sender: Any) {
    }
    

}
