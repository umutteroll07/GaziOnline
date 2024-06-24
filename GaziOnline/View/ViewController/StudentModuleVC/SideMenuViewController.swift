//
//  SideMenuViewController.swift
//  GaziOnline
//
//  Created by Umut Erol on 2.03.2024.
//

import UIKit

class SideMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func clicked_home(_ sender: Any) {
        performSegue(withIdentifier: "toHomeVC", sender: nil)
    }
    
    @IBAction func clicked_firm(_ sender: Any) {
        performSegue(withIdentifier: "toFirmVC", sender: nil)
    }
    
    @IBAction func clicked_forms(_ sender: Any) {
        performSegue(withIdentifier: "toFormsVC", sender: nil)

    }
    
    @IBAction func clicked_surveys(_ sender: Any) {
        performSegue(withIdentifier: "toSurveyVC", sender: nil)

    }
    
    @IBAction func clicked_personInfo(_ sender: Any) {
        performSegue(withIdentifier: "toPersonInfoVC", sender: nil)
    }
    
    
    @IBAction func clicked_logOut(_ sender: Any) {
    }
    
    
    @IBAction func clicked_reports(_ sender: Any) {
        performSegue(withIdentifier: "toReportVC", sender: nil)

    }
    
    
    
}
