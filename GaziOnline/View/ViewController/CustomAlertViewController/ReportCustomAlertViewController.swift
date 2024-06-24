//
//  ReportCustomAlertViewController.swift
//  GaziOnline
//
//  Created by Umut Erol on 17.03.2024.
//

import UIKit


protocol ReportCustomAlertDialog {
    func CancelButtonTapped()
}

class ReportCustomAlertViewController: UIViewController{
    
    
    let studentDB = StudentDB()
    
    @IBOutlet weak var txt_date: UITextField!
    @IBOutlet weak var txt_reportText: UITextField!
    @IBOutlet weak var view_addReport: UIView!
    var delegate : ReportCustomAlertDialog? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
 
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
        animateView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.layoutIfNeeded()
    }
    
    func setupView() {
        view_addReport.layer.cornerRadius = 35
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    func animateView() {
        view_addReport.alpha = 0;
        self.view_addReport.frame.origin.y = self.view_addReport.frame.origin.y + 0
        UIView.animate(withDuration: 0.0, animations: { () -> Void in
            self.view_addReport.alpha = 1.0
            self.view_addReport.frame.origin.y = self.view_addReport.frame.origin.y - 0
            
        })
    }

    @IBAction func clicked_addBtn(_ sender: Any) {
        print("clicked add report btn")
        let reportDesc = self.txt_reportText.text
        studentDB.insertReportOnPostgreSqlDatabase(reportDesc: reportDesc!)
        self.dismiss(animated: true)
        
    }
    
    @IBAction func clicked_backBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
