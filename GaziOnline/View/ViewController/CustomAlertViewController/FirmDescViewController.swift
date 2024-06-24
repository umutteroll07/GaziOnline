//
//  FirmDescViewController.swift
//  GaziOnline
//
//  Created by Umut Erol on 23.05.2024.
//

import UIKit



protocol FirmDescAlerDialog {
    func CancelButtonTapped()
}



class FirmDescViewController: UIViewController {
    
    
    let firmDB = FirmDB()
    var transitionBoolFirmDescCustom = true
    
    @IBOutlet weak var view_firmDesc: UIView!
    @IBOutlet weak var textView_firmDesc: UITextView!
    @IBOutlet weak var tapped_back: UIButton!
    @IBOutlet weak var tapped_editFirmDesc: UIButton!
    
    @IBOutlet weak var tapped_saveChanges: UIButton!
    var firmDesc = String()
    
    var delegate : FirmDescAlerDialog? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if !transitionBoolFirmDescCustom{
            tapped_editFirmDesc.isHidden = true
            tapped_editFirmDesc.isEnabled = false
        }
        
        
        
        
        tapped_saveChanges.isEnabled = false
        tapped_saveChanges.isHidden = true
        tapped_editFirmDesc.addTarget(self, action: #selector(clickedEditDescBtn), for: .touchUpInside)
        
        
        textView_firmDesc.isEditable = false
        textView_firmDesc.text = firmDesc
        tapped_back.addTarget(self, action: #selector(clickedBackBtn), for: .touchUpInside)

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
        view_firmDesc.layer.cornerRadius = 35
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    func animateView() {
        view_firmDesc.alpha = 0;
        self.view_firmDesc.frame.origin.y = self.view_firmDesc.frame.origin.y + 0
        UIView.animate(withDuration: 0.0, animations: { () -> Void in
            self.view_firmDesc.alpha = 1.0
            self.view_firmDesc.frame.origin.y = self.view_firmDesc.frame.origin.y - 0
            
        })
    }
    
    
    
    @objc func clickedEditDescBtn(){
        
        self.textView_firmDesc.isEditable = true
        self.tapped_saveChanges.isHidden = false
        self.tapped_saveChanges.isEnabled = true
        self.tapped_editFirmDesc.setImage(UIImage(systemName: "pencil.circle.fill"), for: .normal)
        self.tapped_saveChanges.addTarget(self, action: #selector(clickedSaveChangesBtn), for: .touchUpInside)

    }
    
    
    @objc func clickedSaveChangesBtn(){
        self.firmDesc = self.textView_firmDesc.text!
        print(firmDesc)
        self.firmDB.updateFirmDescText(newText: firmDesc)
        self.tapped_saveChanges.isHidden = true
        self.tapped_saveChanges.isEnabled = false
        
        self.tapped_editFirmDesc.setImage(UIImage(systemName: "pencil.circle"), for: .normal)
        self.textView_firmDesc.isEditable = false

    }
    
    
    
    
    @objc func clickedBackBtn(){
        self.dismiss(animated: true)
    }


}
