//
//  StudentsFirmViewController.swift
//  GaziOnline
//
//  Created by Umut Erol on 13.03.2024.
//

import UIKit

class StudentsFirmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var tableView_studentsFirm: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setSideMenuBtn(menuBtn)
        tableView_studentsFirm.delegate = self
        tableView_studentsFirm.dataSource = self

    }
    
    func setSideMenuBtn(_ menuBar : UIBarButtonItem) {
        menuBar.target = revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        
        view.addGestureRecognizer(self.revealViewController()
            .panGestureRecognizer())
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView_studentsFirm.dequeueReusableCell(withIdentifier: "toStudentFirmTVCell") as? StudentsFirmsTableViewCell
        
        let separatorLineView = UIView(frame: CGRect(x: 0, y: cell!.frame.size.height - 1, width: cell!.frame.size.width, height: 1))
              separatorLineView.backgroundColor = UIColor.black
              cell!.addSubview(separatorLineView)
        
        cell?.tapped_showStudent.addTarget(self, action: #selector(clickedShowStudent), for: .touchUpInside)
        
        
        cell?.view_tableViewCell.layer.cornerRadius = 35
        cell?.view_tableViewCell.clipsToBounds = true
        
        return cell!
    }
    
    
    
    @objc func clickedShowStudent(){
        
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
