//
//  PersonInfoStudentViewController.swift
//  GaziOnline
//
//  Created by Umut Erol on 14.03.2024.
//

import UIKit

class PersonInfoStudentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , AddTalentCustomDialog , PasswordCustomAlertDialog {
 
    
    var talentsList : [TalentModel] = []
    
    @IBOutlet weak var image_student: UIImageView!
    @IBOutlet weak var lbl_studentNameSurname: UILabel!
    @IBOutlet weak var lbl_studentNo: UITextField!
    @IBOutlet weak var lbl_studentAge: UITextField!
    @IBOutlet weak var lbl_studentFaculty: UITextField!
    @IBOutlet weak var lbl_studentDepartment: UITextField!
  
    @IBOutlet weak var lbl_studentAgno: UITextField!
    @IBOutlet weak var textView_studentDesc: UITextView!
    @IBOutlet weak var lbl_studentFirm: UITextField!
    
    @IBOutlet weak var tapped_addTalent: UIButton!
    
    
    @IBOutlet weak var btn_editPassword: UIBarButtonItem!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var btn_back: UIButton!
    @IBOutlet weak var tappedBtn_saveToEdit: UIButton!
    @IBOutlet weak var tapped_editBtn: UIBarButtonItem!
    
    
    @IBOutlet weak var tableView_talents: UITableView!
    let studentPersonInfoDB = StudentDB()
    
    var transitionBool = true
    var selectedEditPersonInfoBtn = 0

 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTalentInserted), name: Notification.Name("TalentInserted"), object: nil)


        tappedBtn_saveToEdit.isHidden = true
        tappedBtn_saveToEdit.isEnabled = false
        
        getTalent()
        getStudentPersonInfo()
        textView_studentDesc.isEditable = false

        
    
        tableView_talents.delegate = self
        tableView_talents.dataSource = self
        
        tapped_editBtn.isHidden = false
        tapped_editBtn.isEnabled = true
        tapped_editBtn.target = self
        tapped_editBtn.action = #selector(tapped_editPersonInfo)
        selectedEditPersonInfoBtn = 0
        

        if transitionBool {
            btn_back.isHidden = true
            btn_back.isEnabled = false
            
            tapped_addTalent.isHidden = false
            tapped_addTalent.isEnabled = true
            tapped_addTalent.addTarget(self, action: #selector(clicked_addTalent), for: .touchUpInside)
            btn_editPassword.isHidden = false
            btn_editPassword.isEnabled = true
            
            
            // UIButton oluşturma
            let editPasswordButton = UIButton(type: .system)
            editPasswordButton.setImage(UIImage(systemName: "key.viewfinder"), for: .normal)
            editPasswordButton.addTarget(self, action: #selector(tappedEditPasswordButton(_:)), for: .touchUpInside)

            // UIBarButtonItem'a UIButton'ı atama
            btn_editPassword.customView = editPasswordButton
            
            
           
        
        }
        else{
            btn_back.isHidden = false
            btn_back.isEnabled = true
            tapped_addTalent.isHidden = true
            tapped_addTalent.isEnabled = false
            btn_back.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
            
            btn_editPassword.isEnabled = false
            btn_editPassword.isHidden = true
        
          
    
        }
        
     
        self.setSideMenuBtn(menuBtn)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTalentInserted), name: Notification.Name("TalentInserted"), object: nil)

        tableView_talents.reloadData()
    }
    
                                    

    @objc func tappedBackButton() {
        self.dismiss(animated: true)
    }
                                       
                                       
                                       
    @objc func tappedEditPasswordButton(_ sender: UITapGestureRecognizer){
        
        PasswordCustomAlertViewController.listToEditPsw = "fromStudent"
        
        let customAlert = self.storyboard?.instantiateViewController(withIdentifier: "toPasswordCustomAlertVC") as?
        PasswordCustomAlertViewController
        
        customAlert?.delegate = self
        customAlert?.modalPresentationStyle = .overCurrentContext
        customAlert?.providesPresentationContextTransitionStyle = true
        customAlert?.definesPresentationContext = true
        customAlert?.modalTransitionStyle = .crossDissolve
        self.present(customAlert!, animated: true)
    }

    
    func setSideMenuBtn(_ menuBar : UIBarButtonItem) {
        menuBar.target = revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        
        if self.transitionBool {
            view.addGestureRecognizer(self.revealViewController()
                .panGestureRecognizer())
        }

 
        
    }
    
    
    
    @objc func tapped_editPersonInfo() {
        
        if selectedEditPersonInfoBtn == 0 {
            
           
            textView_studentDesc.isEditable  = true
            self.tappedBtn_saveToEdit.isHidden = false
            self.tappedBtn_saveToEdit.isEnabled = true
            tappedBtn_saveToEdit.addTarget(self, action: #selector(tapped_saveEditButton), for: .touchUpInside)
            selectedEditPersonInfoBtn = 1
            tapped_editBtn.image = .remove
            
        }
        else if selectedEditPersonInfoBtn == 1 {
            
           
            self.tappedBtn_saveToEdit.isHidden = true
            self.tappedBtn_saveToEdit.isEnabled = false
            self.textView_studentDesc.isEditable = false
            selectedEditPersonInfoBtn = 0
            tapped_editBtn.image = UIImage(systemName: "pencil.circle")
        }
       
    }
    
   
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return talentsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView_talents.dequeueReusableCell(withIdentifier: "toTalentsTVCell") as? StudentTalentsTableViewCell
        
        cell?.lbl_talentDesc.text = talentsList[indexPath.row].talent_desc
        cell?.lbl_talentLevel.text = talentsList[indexPath.row].talent_level
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            studentPersonInfoDB.deleteTalentFromPostgreSQL(talent_id: talentsList[indexPath.row].skill_id)
            talentsList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
       @objc func clicked_addTalent() {
        
        let customAlert = self.storyboard?.instantiateViewController(withIdentifier: "toAddTalentCustomVC") as?
        AddTalentCustomViewController
        
        customAlert?.delegate = self
        customAlert?.modalPresentationStyle = .overCurrentContext
        customAlert?.providesPresentationContextTransitionStyle = true
        customAlert?.definesPresentationContext = true
        customAlert?.modalTransitionStyle = .crossDissolve
        self.present(customAlert!, animated: true)
        
    }
    
    
  
    
    
    func getTalent() {
        
        print("called getTalent")
            
            talentsList = try studentPersonInfoDB.fetchTalentsFromPostgreSql()
            for talent in talentsList {
                print(talent.skill_id)
            }
        
    }
    
    
    func getStudentPersonInfo() {
        do {
            let studentInfo = try studentPersonInfoDB.fetchStudentPersonInfo()
            self.lbl_studentNameSurname.text = "\(studentInfo?.name ?? "-") \(studentInfo?.surname ?? "-")"
            self.lbl_studentNo.text = studentInfo?.id
            self.lbl_studentAgno.text = studentInfo?.student_agno ?? "-"
            self.textView_studentDesc.text = studentInfo?.student_desc ?? "..."
            
        }
        catch{
            print("error second try")
        }
        
    }
    
    
    @objc func tapped_saveEditButton() {
        
        print("clicked saveEditBtn")
        let updateDesc = textView_studentDesc.text
        studentPersonInfoDB.updatePersonInfoFromDatabase(updateDesc: updateDesc!)
        showToast(message: "Güncelleme işleminiz gerçekleştirildi.")

        
    }
    
    
    
    // Yetenek eklendiğinde bu fonksiyon çağrılacak
    @objc func handleTalentInserted() {
        tableView_talents.reloadData()
    }
    
    func CancelButtonTapped() {
        
    }
    
 
    
    func showToast(message: String) {
           let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height-100, width: 300, height: 35))
           toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
           toastLabel.textColor = UIColor.white
           toastLabel.textAlignment = .center;
           toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
           toastLabel.text = message
           toastLabel.alpha = 1.0
           toastLabel.layer.cornerRadius = 10;
           toastLabel.clipsToBounds  =  true
           self.view.addSubview(toastLabel)
           UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
               toastLabel.alpha = 0.0
           }, completion: {(isCompleted) in
               toastLabel.removeFromSuperview()
           })
       }
    
    
 
}
