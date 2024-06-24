//
//  GroupsLecturerViewController.swift
//  GaziOnline
//
//  Created by Umut Erol on 13.03.2024.
//

import UIKit

class GroupsLecturerViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource ,CustomAlertDialog{
  
    
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var tableView_groups: UITableView!
    let lecturerDB = LecturerDB()
    var groupId_list : [Int] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView_groups.delegate = self
        tableView_groups.dataSource = self
        self.setSideMenuBtn(menuBtn)
        
        
        
        groupId_list = lecturerDB.fetchGroup_forLecturer()
        

    }
    
    
    
    func setSideMenuBtn(_ menuBar : UIBarButtonItem) {
        menuBar.target = revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        
        view.addGestureRecognizer(self.revealViewController()
            .panGestureRecognizer())
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupId_list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView_groups.dequeueReusableCell(withIdentifier: "toGroupsLectureCell") as? GroupsLectureTableViewCell
        
        cell?.view_groupsTableViewCell.layer.cornerRadius = 35
        cell?.view_groupsTableViewCell.clipsToBounds = true
      
        
        cell?.lbl_groupName.text = "Grup \(groupId_list[indexPath.row])"
        
        var selectedGroupId = groupId_list[indexPath.row]
        cell?.tapped_showButton.tag = selectedGroupId
     
        
        cell?.tapped_showButton.addTarget(self, action: #selector(tapped_showBtn), for: .touchUpInside)

        
        return cell!
    }
    

    
  
    @objc func tapped_showBtn(_ sender: UIButton) {
        
        let chosenGroupId = sender.tag
        CustomAlertViewController.selectedGroupId = chosenGroupId
        
        
        let customAlert = self.storyboard?.instantiateViewController(withIdentifier: "toCustomAlertVC") as? CustomAlertViewController
        customAlert?.delegate = self
        customAlert?.modalPresentationStyle = .overCurrentContext
        customAlert?.providesPresentationContextTransitionStyle = true
        customAlert?.definesPresentationContext = true
        customAlert?.modalTransitionStyle = .coverVertical
        self.present(customAlert!, animated: true)
    }
   
    
    
    
    @IBAction func clicked_addGroup(_ sender: Any) {
        print("created new group")
    }
    
    
    func CancelButtonTapped() {
        
    }
    
   

}
