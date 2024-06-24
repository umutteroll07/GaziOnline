//
//  SignInLecturerViewController.swift
//  GaziOnline
//
//  Created by Umut Erol on 14.03.2024.
//

import UIKit

class SignInLecturerViewController: UIViewController {
  
    
    @IBOutlet weak var txt_lecturerNo: UITextField!

    @IBOutlet weak var txt_lecturerPassword: UITextField!
    
    var lecturerNo = Int()
    var lecturerPassword = String()
    
    
    let lecturerDBAcces = LecturerDBAccess()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    

    @IBAction func clicked_SignIn(_ sender: Any) {
        
        
        if let enterLecturerNo = txt_lecturerNo.text , let enterLecturerPsw = txt_lecturerPassword.text {
            
            if let lecturerId = Int(enterLecturerNo) {
             
                lecturerDBAcces.signIn_forLecturer(lecturerNo: lecturerId, lecturerPsw: enterLecturerPsw)
                if(lecturerDBAcces.passwordCorrect) {
                    let revealVC = self.storyboard?.instantiateViewController(identifier: "toRevealVC_lecturer") as? SWRevealViewController
                    self.navigationController?.pushViewController(revealVC!, animated: true)
                    navigationController?.setNavigationBarHidden(true, animated: false)
                }
                else {
                    makeAlert(title: "İşlem hatası!", message: "Lütfen bilgilerinizi kontrol ediniz!")
                }
                
                
            }
            else {
                makeAlert(title: "İşlem hatası!", message: "Lütfen bilgilerinizi kontrol ediniz!")
            }
            
            
            
        }
        else {
            self.makeAlert(title: "İşlem hatası!", message: "Lütfen bilgilerinizi giriniz!")
        }
        
    
    }
    
    
    func makeAlert(title : String , message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(alertAction)
        self.present(alert, animated: true)
    }

}
