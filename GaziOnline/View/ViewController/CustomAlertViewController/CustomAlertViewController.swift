//
//  CustomAlertViewController.swift
//  GaziOnline
//
//  Created by Umut Erol on 15.03.2024.
//

import UIKit


protocol CustomAlertDialog {
    func CancelButtonTapped()
}


class CustomAlertViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    
    @IBOutlet weak var tableView_alert: UITableView!
    @IBOutlet weak var view_alert: UIView!
    
    var studentsInGroupList : [Int] = []
    static var selectedGroupId = Int()
    
    
    let lectureDB = LecturerDB()
    var delegate : CustomAlertDialog? = nil
  

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        studentsInGroupList = lectureDB.fetchStudentInGroup(groupId: CustomAlertViewController.selectedGroupId)
        
        tableView_alert.delegate = self
        tableView_alert.dataSource = self

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
        view_alert.layer.cornerRadius = 35
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    func animateView() {
        view_alert.alpha = 0;
        self.view_alert.frame.origin.y = self.view_alert.frame.origin.y + 0
        UIView.animate(withDuration: 0.0, animations: { () -> Void in
            self.view_alert.alpha = 1.0
            self.view_alert.frame.origin.y = self.view_alert.frame.origin.y - 0
            
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentsInGroupList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView_alert.dequeueReusableCell(withIdentifier: "toAlertGroupTVCell") as? CustomAlertGroupTableViewCell
                
        
        let fetchStudentId = Int(studentsInGroupList[indexPath.row])
        let fetchStudentName = lectureDB.fetchStudentNameWithIdForGroup(studentId:fetchStudentId )
        
        cell?.lbl_name.text = fetchStudentName
        
        cell?.tapped_showReport.tag = studentsInGroupList[indexPath.row]
        cell?.tapped_showReport.addTarget(self, action: #selector(clicked_showReport), for: .touchUpInside)
        
        
        cell?.tapped_showStudent.tag = studentsInGroupList[indexPath.row]
        cell?.tapped_showStudent.addTarget(self, action: #selector(clickedShowStudent), for: .touchUpInside)
        return cell!
    }
    
    
    @objc func clickedShowStudent(_ sender: UIButton) {
        
        print("clickedShowStudent")
        let studentId = sender.tag
        StudentDB.currentlyStudentNoDB = studentId
        
        if let studentVC = self.storyboard?.instantiateViewController(withIdentifier: "toStudentInfoVC") as? PersonInfoStudentViewController {
            
            studentVC.transitionBool = false
            studentVC.modalPresentationStyle = .fullScreen
            self.present(studentVC, animated: true)
        }
        else {
            print("View Controller is not found")
        }

     
    }
    
    
    @objc func clicked_showReport(_ sender: UIButton) {
        print("clickedShowReport")
        
        
        let studentId = sender.tag
        StudentDB.currentlyStudentNoDB = studentId
        
        if let reportStudentVC = self.storyboard?.instantiateViewController(identifier: "toReportStudentVC")
            as? ReportStudentViewController {
            reportStudentVC.transitionBoolReport = false
            reportStudentVC.modalPresentationStyle = .fullScreen
            self.present(reportStudentVC, animated: true)
            
        }
        else {
            print("Hata: ViewController örneklenemedi.")
        }
            
        
    }
    
    
    @IBAction func clicked_backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    

}
