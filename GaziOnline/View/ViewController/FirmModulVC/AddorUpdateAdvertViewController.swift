//
//  AddAdvertViewController.swift
//  GaziOnline
//
//  Created by Umut Erol on 25.05.2024.
//

import UIKit

class AddorUpdateAdvertViewController: UIViewController, UITextViewDelegate {
    
    
    let firmDB = FirmDB()
    var transitionBool = false
    
    var advertDescString = String()
    var advertTitleString = String()
    var advertPostTitleString = String()
    var advertStartDateString = String()
    var advertEndDateString = String()
    
    
    @IBOutlet weak var textView_advertTitle: UITextView!
    @IBOutlet weak var textView_advertDesc: UITextView!
    @IBOutlet weak var textView_postTitle: UITextView!
    
    @IBOutlet weak var lbl_postTitleTag: UITextField!
    
    @IBOutlet weak var tapped_shareAdvertAsPostBtn: UIButton!
    @IBOutlet weak var tapped_shareAdvertBtn: UIButton!
    
    
    @IBOutlet weak var startAdvertDatePicker: UIDatePicker!
    @IBOutlet weak var endAdvertDatePicker: UIDatePicker!
    
    
    var advertTitle = String()
    var advertDesc = String()
    var postTitle = String()
    
    var startDate = String()
    var endDate = String()
    let dateFormatter = DateFormatter()
    
    var chosenSharePost = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        
        // Set delegates
        textView_advertTitle.delegate = self
        textView_advertDesc.delegate = self
        textView_postTitle.delegate = self
        
        
        setInitView()
        tapped_shareAdvertAsPostBtn.addTarget(self, action: #selector(clickedShareAdvertAsPostBtn), for: .touchUpInside)
        tapped_shareAdvertBtn.addTarget(self, action: #selector(clickedSharedAdvertBtn), for: .touchUpInside)
        textView_postTitle.isHidden = true
        lbl_postTitleTag.isHidden = true
        
        
        
        
        if transitionBool {
            textView_advertDesc.text = advertDescString
            textView_advertTitle.text = advertTitleString
            print(advertStartDateString)
            print(advertEndDateString)
            
            advertStartDateString =  convertDateString(advertStartDateString)!
            advertEndDateString = convertDateString(advertEndDateString)!
            
            print(advertStartDateString)
            print(advertEndDateString)
            
            setDatePickerValue(from: advertStartDateString, endDateString: advertEndDateString)
            if let postTitle = advertPostTitleString as? String{
                if postTitle != "nil" {
                    lbl_postTitleTag.isHidden = false
                    textView_postTitle.isHidden = false
                    textView_postTitle.text = postTitle
                    // Butonun mevcut görüntüsünü kontrol et ve değiştir
                    if let currentImage = tapped_shareAdvertAsPostBtn.imageView?.image {
                        if currentImage == UIImage(systemName: "square.dashed") {
                            tapped_shareAdvertAsPostBtn.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
                        }
                    }

                }
            }
        }
        
        

    }
    
    @objc func clickedShareAdvertAsPostBtn() {
        
        // Görünürlük durumlarını tersine çevir
        textView_postTitle.isHidden.toggle()
        lbl_postTitleTag.isHidden.toggle()
        
        // Butonun mevcut görüntüsünü kontrol et ve değiştir
        if let currentImage = tapped_shareAdvertAsPostBtn.imageView?.image {
            if currentImage == UIImage(systemName: "square.dashed") {
                tapped_shareAdvertAsPostBtn.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            } else if currentImage == UIImage(systemName: "checkmark.square.fill") {
                tapped_shareAdvertAsPostBtn.setImage(UIImage(systemName: "square.dashed"), for: .normal)
            }
        }
    }
    
    
    private func setInitView() {
        dateFormatter.dateFormat = "yyyy/MM/dd"
        startAdvertDatePicker.datePickerMode = .date
        endAdvertDatePicker.datePickerMode = .date
        
        startDate = dateFormatter.string(from: startAdvertDatePicker.date)
        endDate = dateFormatter.string(from: endAdvertDatePicker.date)
        
        
    }
    
    func convertDateString(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "yyyy/MM/dd"
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }

    
    func setDateFromString(_ dateString: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.date(from: dateString)
    }

    func setDatePickerValue(from startDateString: String, endDateString: String) {
        // Start Date
        if let startDate = setDateFromString(startDateString) {
            startAdvertDatePicker.setDate(startDate, animated: true)
        } else {
            print("Geçersiz başlangıç tarih formatı")
        }
        
        // End Date
        if let endDate = setDateFromString(endDateString) {
            endAdvertDatePicker.setDate(endDate, animated: true)
        } else {
            print("Geçersiz bitiş tarih formatı")
        }
    }


    
    @IBAction func didChangeStartAdvertDatePicker(_ sender: UIDatePicker) {
        startDate = dateFormatter.string(from: sender.date)
        view.endEditing(true)
    }
    
    @IBAction func didChangeEndAdvertDatePicker(_ sender: UIDatePicker) {
        endDate = dateFormatter.string(from: sender.date)
        view.endEditing(true)
    }
    

    func textViewDidChange(_ textView: UITextView) {
        if textView == textView_advertTitle {
            advertTitle = textView.text
        } else if textView == textView_advertDesc {
            advertDesc = textView.text
        } else if textView == textView_postTitle {
            postTitle = textView.text
                   
        }
    }
    
    
    @objc func clickedSharedAdvertBtn(){
        
        
        print(startDate)
        print(endDate)
        let firmId = firmDB.fetchFirmIdWithFirmnNo()
      
        
        let advert = AdvertModel(advertDesc: self.advertDesc, advertTitle: self.advertTitle, postTitle: self.postTitle, startDate: self.startDate, endDate: self.endDate, firmId: firmId)
        
        print("id : \(advert.firmId)")
        firmDB.insertAdvertOnPostgreSql(advert: advert)
        
        let homePage = self.storyboard?.instantiateViewController(identifier: "toAdvertFirmVC") as? AdvertsFirmViewController
        self.navigationController?.pushViewController(homePage!, animated: true)
    }
    
    
    

}
