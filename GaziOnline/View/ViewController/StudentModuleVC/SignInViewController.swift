//
//  SignInViewController.swift
//  GaziOnline
//
//  Created by Umut Erol on 1.03.2024.
//

import UIKit

class SignInViewController: UIViewController {
    
    let studentDBAccess = StudentDBAccess()
    
    @IBOutlet weak var txt_studentNumber: UITextField!
    @IBOutlet weak var txt_studentPsw: UITextField!
    
    var studentNumber = Int()
    var studentPsw = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        studentDBAccess.signIn_forStudent(studentNumber: studentNumber , password: studentPsw)
     

        
    }
    
    @IBAction func clicked_signIn(_ sender: Any) {
        
        // textField.text'ten alınan değeri güvenli bir şekilde String'e dönüştürme
        if let studentNumberText = txt_studentNumber.text, let studentPswText = txt_studentPsw.text {
            // String değeri Int türüne dönüştürme
            if let studentNumber = Int(studentNumberText) {
                // studentNumber değerini kullanabilirsiniz
                print("Öğrenci numarası: \(studentNumber)")
                
                // studentPswText değerini kullanabilirsiniz
                let studentPsw = studentPswText
                print("Öğrenci parolası: \(studentPsw)")
                
                studentDBAccess.signIn_forStudent(studentNumber: studentNumber, password: studentPsw)
                    if(studentDBAccess.passwordCorrect){
                        
                       let revealVC = self.storyboard?.instantiateViewController(identifier: "toRevealVC") as? SWRevealViewController
                      self.navigationController?.pushViewController(revealVC!, animated: true)
                      navigationController?.setNavigationBarHidden(true, animated: false)
                    }
                    else{
                        makeAlert(title: "İşlem Hatası", message: "Lütfen bilgilerinizi kontrol ediniz!")
                    }

            } else {
                self.makeAlert(title: "İşlem Hatası.", message: "Lütfen bilgilerinizi kontrol ediniz.")
            }
        } else {
            self.makeAlert(title: "İşlem Hatası", message: "Lütfen bilgilerinizi giriniz.")
        }

        
        
 
        
    }
    
    
    func makeAlert(title:String , message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }

}
