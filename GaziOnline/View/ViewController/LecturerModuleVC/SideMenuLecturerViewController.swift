//
//  SupervizorSideMenuViewController.swift
//  GaziOnline
//
//  Created by Umut Erol on 11.03.2024.
//

import UIKit

class SideMenuLecturerViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }
  
    @IBAction func clicked_homePage(_ sender: Any) {
        performSegue(withIdentifier: "toHomeLecturerVC", sender: nil)
    }
    
    @IBAction func clicked_students(_ sender: Any) {
        performSegue(withIdentifier: "toStudentsLecturerVC", sender: nil)
    }
    
    @IBAction func clicked_firms(_ sender: Any) {
        performSegue(withIdentifier: "toFirmsLectureVC", sender: nil)
    }
    
    @IBAction func clicked_groups(_ sender: Any) {
        performSegue(withIdentifier: "toGroupsLectureVC", sender: nil)
    }
    
    @IBAction func clicked_forms(_ sender: Any) {
        performSegue(withIdentifier: "toFormsLectureVC", sender: nil)
    }
    
    @IBAction func clicked_surveys(_ sender: Any) {
        performSegue(withIdentifier: "toSurveyLectureVC", sender: nil)
    }
    
    
    @IBAction func clicked_personInfo(_ sender: Any) {
        performSegue(withIdentifier: "toLecturePersonInfoVC", sender: nil)
    }
    
    @IBAction func clicked_logOut(_ sender: Any) {
    }
    
    
    
}
