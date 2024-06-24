//
//  PersonInfoLecturerViewController.swift
//  GaziOnline
//
//  Created by Umut Erol on 13.05.2024.
//

import UIKit

class PersonInfoLecturerViewController: UIViewController, PasswordCustomAlertDialog {
   
    
    
    @IBOutlet weak var lbl_lecturerName: UILabel!
    @IBOutlet weak var txt_lecturerEposta: UITextField!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var btn_editPassword: UIBarButtonItem!
    
    
    let lecturerDB = LecturerDB()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setSideMenuBtn(menuBtn)
        self.getLecturerPersonInfo()
        
        
        // UIButton oluşturma
        let editPasswordButton = UIButton(type: .system)
        editPasswordButton.setImage(UIImage(systemName: "key.viewfinder"), for: .normal)
        editPasswordButton.addTarget(self, action: #selector(tappedEditPasswordButton(_:)), for: .touchUpInside)

        // UIBarButtonItem'a UIButton'ı atama
        btn_editPassword.customView = editPasswordButton

    }
    
    func setSideMenuBtn(_ menuBar : UIBarButtonItem) {
        menuBar.target = revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        
        view.addGestureRecognizer(self.revealViewController()
            .panGestureRecognizer())
        
    }
    
    
    @objc func tappedEditPasswordButton(_ sender: UITapGestureRecognizer){
        
        PasswordCustomAlertViewController.listToEditPsw = "fromLecturer"
        
        
        let customAlert = self.storyboard?.instantiateViewController(withIdentifier: "toPasswordCustomAlertVC") as?
        PasswordCustomAlertViewController
        
        customAlert?.delegate = self
        customAlert?.modalPresentationStyle = .overCurrentContext
        customAlert?.providesPresentationContextTransitionStyle = true
        customAlert?.definesPresentationContext = true
        customAlert?.modalTransitionStyle = .crossDissolve
        self.present(customAlert!, animated: true)
    }
    
    func getLecturerPersonInfo() {
        
        do {
            let lecturerInfo = try lecturerDB.fetchLecturerPersonInfo()
            self.lbl_lecturerName.text = "\(lecturerInfo?.lecturerName ?? "-") \(lecturerInfo?.lecturerSurname ?? "-")"
            self.txt_lecturerEposta.isEnabled = false
            self.txt_lecturerEposta.text = lecturerInfo?.lecturerEposta

        }
        catch{
            print("error /set lecturerPersonInfoView")
        }
        
        
    }
    
    
    func CancelButtonTapped() {
        
    }
    
    


}
