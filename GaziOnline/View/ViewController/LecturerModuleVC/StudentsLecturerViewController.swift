//
//  StudentsLecturerViewController.swift
//  GaziOnline
//
//  Created by Umut Erol on 12.03.2024.
//

import UIKit

class StudentsLecturerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    

    @IBOutlet weak var tableView_students: UITableView!
    @IBOutlet weak var menuBtn: UIBarButtonItem!

    let lecturerDB = LecturerDB()
    var studentsList : [StudentPersonInfoModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setSideMenuBtn(menuBtn)
        tableView_students.delegate = self
        tableView_students.dataSource = self

        studentsList = lecturerDB.fetchStudent_forLecturer()
        
    
    }
    
    
    
    func setSideMenuBtn(_ menuBar : UIBarButtonItem) {
        menuBar.target = revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        
        view.addGestureRecognizer(self.revealViewController()
            .panGestureRecognizer())
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView_students.dequeueReusableCell(withIdentifier: "toStudentLectureTVCell") as? StudentsLectureTableViewCell
        
        cell?.view_tableViewCell.layer.cornerRadius = 35
        cell?.view_tableViewCell.clipsToBounds = true
        
        
        cell?.txt_studentName.text = "\(studentsList[indexPath.row].name) \(studentsList[indexPath.row].surname)"
        StudentDB.currentlyStudentNoDB = Int(studentsList[indexPath.row].id) ?? 0


        let currentlyStudentId = Int(studentsList[indexPath.row].id) ?? 0
        
        // Set tag to uniquely identify the cell
        cell?.tapped_showStudent.tag = currentlyStudentId
        
        cell?.tapped_showStudent.addTarget(self, action: #selector(clicked_showStudentOnCell), for: .touchUpInside)
        return cell!
    }
    
    @objc func clicked_showStudentOnCell(_ sender: UIButton) {
        
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
    


}
