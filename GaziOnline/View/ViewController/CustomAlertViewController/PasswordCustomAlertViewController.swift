//
//  PasswordCustomAlertViewController.swift
//  GaziOnline
//
//  Created by Umut Erol on 13.05.2024.
//

import UIKit

protocol PasswordCustomAlertDialog {
    func CancelButtonTapped()
}


class PasswordCustomAlertViewController: UIViewController, UITextFieldDelegate {
    
    
    var currentlyUserPswFromDatabase = String()
    
    let studentDB = StudentDB()
    let lecturerDB = LecturerDB()
    static var listToEditPsw = String()
    
    
    
    @IBOutlet weak var view_pswCustomAlert: UIView!
    @IBOutlet weak var txt_currentlyPsw: UITextField!
    @IBOutlet weak var txt_newPsw: UITextField!
    @IBOutlet weak var txt_newPswAgain: UITextField!
    @IBOutlet weak var tapped_updateBtn: UIButton!
    
    
    var delegate : PasswordCustomAlertDialog? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tapped_updateBtn.isEnabled = false
        txt_newPsw.delegate = self
        

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
        view_pswCustomAlert.layer.cornerRadius = 35
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    func animateView() {
        view_pswCustomAlert.alpha = 0;
        self.view_pswCustomAlert.frame.origin.y = self.view_pswCustomAlert.frame.origin.y + 0
        UIView.animate(withDuration: 0.0, animations: { () -> Void in
            self.view_pswCustomAlert.alpha = 1.0
            self.view_pswCustomAlert.frame.origin.y = self.view_pswCustomAlert.frame.origin.y - 0
            
        })
    }
    
    
    @objc func clicked_updatePsw() {
       
        let currentlyPsw = self.txt_currentlyPsw.text
        let newPsw = self.txt_newPsw.text
        let newPswAgain = self.txt_newPswAgain.text
        
        
        
        if (PasswordCustomAlertViewController.listToEditPsw == "fromStudent"){
            
            print(StudentDB.currentlyStudentNoDB)
            currentlyUserPswFromDatabase = studentDB.fetchPassworFromDatabase(student_no: StudentDB.currentlyStudentNoDB)
            
        }
        else if (PasswordCustomAlertViewController.listToEditPsw == "fromLecturer") {
            print(LecturerDB.currentlyLecturer)
            currentlyUserPswFromDatabase = lecturerDB.fetchPassworFromDatabase(izleyici_no: LecturerDB.currentlyLecturer)
            
        }
        
        print("currentlyPsw : \(currentlyUserPswFromDatabase)")

        if (currentlyPsw == currentlyUserPswFromDatabase) {
            
            if (newPsw == newPswAgain){
                
                
                if (PasswordCustomAlertViewController.listToEditPsw == "fromStudent"){
                  
                    
                    studentDB.updatePasswordStudent(newParola: newPsw!)
                }
                else if (PasswordCustomAlertViewController.listToEditPsw == "fromLecturer") {
                    lecturerDB.updatePasswordStudent(newParola: newPsw!)
                }
                
                
              
                self.showToast(message: "İşlem Gerçekleştirildi")
                txt_currentlyPsw.text = ""
                txt_newPsw.text = ""
                txt_newPswAgain.text = ""
            }
            else {
                self.makeAlert(title: "İşlem gerçekleştirilemedi", message: "Yeni şifreyi tekrar giriniz!")

            }
        }
        else {
            self.makeAlert(title: "İşlem gerçekleştirilemedi!", message: "Mevcut şifreniz hatalı!")
        }
        
    }
    

    @IBAction func btn_back(_ sender: Any) {
        self.dismiss(animated: true)
    }

    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // TextField'in yeni metni
        let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if newText.count < 8 {
            tapped_updateBtn.isEnabled = false
        }
        else {
            tapped_updateBtn.isEnabled = true
            tapped_updateBtn.addTarget(self, action: #selector(clicked_updatePsw), for: .touchUpInside)
        }
        
        return true
    }
    
    
    
    
    
    func makeAlert(title:String , message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func showToast(message: String) {
           let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
           toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
           toastLabel.textColor = UIColor.white
           toastLabel.textAlignment = .center
           toastLabel.font = UIFont.systemFont(ofSize: 12)
           toastLabel.text = message
           toastLabel.alpha = 1.0
           toastLabel.layer.cornerRadius = 10
           toastLabel.clipsToBounds = true
           self.view.addSubview(toastLabel)
           UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
               toastLabel.alpha = 0.0
           }, completion: {(isCompleted) in
               toastLabel.removeFromSuperview()
           })
       }
}
