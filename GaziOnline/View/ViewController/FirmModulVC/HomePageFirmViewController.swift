//
//  HomePageFirmViewController.swift
//  GaziOnline
//
//  Created by Umut Erol on 13.03.2024.
//

import UIKit

class HomePageFirmViewController: UIViewController , FirmDescAlerDialog{
  
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    var transitionBoolFirm = true
    

    @IBOutlet weak var imageView_firmLogo: UIImageView!
    @IBOutlet weak var lbl_firmName: UILabel!
    @IBOutlet weak var lbl_firmSector: UITextField!
    @IBOutlet weak var lbl_firmEmail: UITextField!
    @IBOutlet weak var textView_location: UITextView!
    @IBOutlet weak var tapped_backBtn: UIButton!
    
    var firmDesc = String()
    let firmDB = FirmDB()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if transitionBoolFirm{
            self.setSideMenuBtn(menuBtn)
            tapped_backBtn.isHidden = true
            tapped_backBtn.isEnabled = false
        }
        else {
            
            tapped_backBtn.isHidden = false
            tapped_backBtn.isEnabled = true
            tapped_backBtn.addTarget(self, action: #selector(clicked_backBtn), for: .touchUpInside)
            
        }

        
        
        // Köşe yuvarlama
               imageView_firmLogo.layer.cornerRadius = 15
               imageView_firmLogo.clipsToBounds = true
               
               // Kenarlık ekleme
               imageView_firmLogo.layer.borderWidth = 2
               imageView_firmLogo.layer.borderColor = UIColor.lightGray.cgColor
               
               // Gölge ekleme
               imageView_firmLogo.layer.shadowColor = UIColor.black.cgColor
               imageView_firmLogo.layer.shadowOpacity = 0.5
               imageView_firmLogo.layer.shadowOffset = CGSize(width: 5, height: 5)
               imageView_firmLogo.layer.shadowRadius = 10
               imageView_firmLogo.layer.masksToBounds = false
        
        
              // Firma adı label'ı için stil ayarlamaları
              lbl_firmName.font = UIFont.boldSystemFont(ofSize: 24)
              lbl_firmName.textColor = UIColor.black
              
        // Firma sektörü ve email textfield'ları için stil ayarlamaları
              setupTextField(textField: lbl_firmSector, placeholder: "Firma Sektörü")
              setupTextField(textField: lbl_firmEmail, placeholder: "Firma Email")
              
              // Konum textview için stil ayarlamaları
              textView_location.layer.borderWidth = 1
              textView_location.layer.borderColor = UIColor.lightGray.cgColor
              textView_location.layer.cornerRadius = 5
              textView_location.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        
      
      
        
        // UITextView'in çerçeve rengini ve kalınlığını ayarla
        textView_location.layer.borderColor = UIColor.black.cgColor
        textView_location.layer.borderWidth = 0.8
        
        imageView_firmLogo.layer.borderColor = UIColor.black.cgColor
        imageView_firmLogo.layer.borderWidth = 0.8
              
  
        self.getFirmInfo()

    }
    

    
    func setSideMenuBtn(_ menuBar : UIBarButtonItem) {
        menuBar.target = revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        
        view.addGestureRecognizer(self.revealViewController()
            .panGestureRecognizer())
        
    }
    
    
    func getFirmInfo(){
      
        do{
            let firm = try firmDB.fetchFirmInfoFromDatabase()
            
           
          
           
            let imageUrl = (firm?.firm_logo)!
            if let url = URL(string: imageUrl) {
                imageView_firmLogo.loadImage(from: url)
            }
            self.lbl_firmName.text = firm?.firm_name
            self.lbl_firmEmail.text = firm?.firm_eposta
            self.lbl_firmSector.text = firm?.firm_sector
            self.textView_location.text = firm?.firm_location
            
            
        }
        catch{
            print("home page error")
        }
    }
 
    
    @IBAction func clicked_descreption(_ sender: Any) {
        
        do {
            let firm = try firmDB.fetchFirmInfoFromDatabase()
            self.firmDesc = firm?.firm_desc ?? "---"
        }
        catch{
            print(error)
        }
    
        let customAlert = self.storyboard?.instantiateViewController(withIdentifier: "toFirmDescAlertDialogVC") as?
        FirmDescViewController
        
        customAlert?.transitionBoolFirmDescCustom  = self.transitionBoolFirm
        
        customAlert?.delegate = self
        customAlert?.delegate = self
        customAlert?.modalPresentationStyle = .overCurrentContext
        customAlert?.providesPresentationContextTransitionStyle = true
        customAlert?.definesPresentationContext = true
        customAlert?.modalTransitionStyle = .crossDissolve
        customAlert?.firmDesc = self.firmDesc
        self.present(customAlert!, animated: true)
        
        
    
        
        
        
        
    }
    
    
    @objc func clicked_backBtn(){
        self.dismiss(animated: true)
    }
    

    func setupTextField(textField: UITextField, placeholder: String) {
          textField.borderStyle = .roundedRect
          textField.placeholder = placeholder
          textField.backgroundColor = UIColor(white: 0.95, alpha: 1)
      }
    
    
    func CancelButtonTapped() {
        
    }
    
    
    

}



extension  UIImageView {
    
    func loadImage(from url: URL) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                // Hata kontrolü
                if let error = error {
                    print("Error loading image: \(error)")
                    return
                }
                // Veri ve response kontrolü
                guard let data = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print("Invalid response or data")
                    return
                }
                // Görüntüyü oluşturma ve ana thread'de ayarlama
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }.resume()
        }

}





