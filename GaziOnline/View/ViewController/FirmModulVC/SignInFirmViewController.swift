//
//  SignInFirmViewController.swift
//  GaziOnline
//
//  Created by Umut Erol on 14.03.2024.
//

import UIKit

class SignInFirmViewController: UIViewController {
    

    
    @IBOutlet weak var txt_firmNo: UITextField!
    
    @IBOutlet weak var txt_password: UITextField!
    let firmDBAccess = FirmDBAccess()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func clicked_SignIn(_ sender: Any) {
        
      
            
            
        // textField.text'ten alınan değeri güvenli bir şekilde String'e dönüştürme
        if let firmNoText = txt_firmNo.text, let firmPswText = txt_password.text {
            
            // textField.text'ten alınan değeri güvenli bir şekilde String'e dönüştürme
                 if let firmNoText = txt_firmNo.text, let firmPswText = txt_password.text {
                     print("firma numarası: \(firmNoText)")
                     print("firma parolası: \(firmPswText)")

                     firmDBAccess.signIn_forFirm(firmNo: firmNoText, firmPassword: firmPswText)

                     if firmDBAccess.passwordCorrect {
                         let revealVC = self.storyboard?.instantiateViewController(identifier: "toRevealVC_firm") as? SWRevealViewController
                         if let revealVC = revealVC {
                             self.navigationController?.pushViewController(revealVC, animated: true)
                             navigationController?.setNavigationBarHidden(true, animated: false)
                         }
                     } else {
                         makeAlert(title: "İşlem Hatası", message: "Lütfen bilgilerinizi kontrol ediniz!")
                     }
                 } else {
                     self.makeAlert(title: "İşlem Hatası.", message: "Lütfen bilgilerinizi kontrol ediniz.")
                 }
        }
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    
    func makeAlert(title:String , message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(alertAction)
        self.present(alert, animated: true)
    }
    

}
