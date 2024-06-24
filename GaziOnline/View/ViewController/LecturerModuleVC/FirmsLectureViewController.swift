//
//  FirmsLectureViewController.swift
//  GaziOnline
//
//  Created by Umut Erol on 13.03.2024.
//

import UIKit

class FirmsLectureViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    
    var firmList : [FirmFirstViewInfoModel] = []
    let studentDB = StudentDB()
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    
    @IBOutlet weak var collectionView_firmsForLecture: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        firmList = studentDB.fetchFirm_forStudents()
        
        
        self.setSideMenuBtn(menuBtn)
        collectionView_firmsForLecture.delegate = self
        collectionView_firmsForLecture.dataSource = self

    }
    
    func setSideMenuBtn(_ menuBar : UIBarButtonItem) {
        menuBar.target = revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        
        view.addGestureRecognizer(self.revealViewController()
            .panGestureRecognizer())
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return firmList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView_firmsForLecture.dequeueReusableCell(withReuseIdentifier: "toFirmsCVCell", for: indexPath) as? FirmsLectureCollectionViewCell
        
        // Cell styling
        cell?.view_collectionViewFirms.layer.cornerRadius = 10
        cell?.view_collectionViewFirms.layer.borderWidth = 1
        cell?.view_collectionViewFirms.layer.borderColor = UIColor.lightGray.cgColor
        cell?.view_collectionViewFirms.layer.shadowColor = UIColor.black.cgColor
        cell?.view_collectionViewFirms.layer.shadowOpacity = 0.2
        cell?.view_collectionViewFirms.layer.shadowOffset = CGSize(width: 3, height: 3)
        cell?.view_collectionViewFirms.layer.shadowRadius = 4
        cell?.view_collectionViewFirms.layer.masksToBounds = false

        
        cell?.lbl_firmName.layer.cornerRadius = 5
        cell?.lbl_firmName.layer.borderWidth = 1
        cell?.lbl_firmName.layer.borderColor = UIColor.lightGray.cgColor
        cell?.lbl_firmName.layer.shadowColor = UIColor.black.cgColor
        cell?.lbl_firmName.layer.shadowOpacity = 0.2
        cell?.lbl_firmName.layer.shadowOffset = CGSize(width: 3, height: 3)
        cell?.lbl_firmName.layer.shadowRadius = 4
        cell?.lbl_firmName.layer.masksToBounds = true
        
        

        cell?.view_collectionViewFirms.layer.cornerRadius = 35
        cell?.view_collectionViewFirms.clipsToBounds = true
        
        let imageUrl = firmList[indexPath.row].firm_logo
        if let url = URL(string: imageUrl) {
            cell?.image_logo.loadImageFirmLogo(from: url)
        }
        cell?.lbl_firmName.text = firmList[indexPath.row].firm_name
        
        
        
        cell?.tapped_showFirm.tag = Int(firmList[indexPath.row].firm_no)!
        cell?.tapped_showFirm.addTarget(self, action: #selector(clicked_view_apply_btn), for: .touchUpInside)

      
        
        return cell!
        
        
    }
    
    
    // Layout settings for cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width - 20, height: 150)
    }
    
    @objc func clicked_view_apply_btn(_ sender: UIButton) {
        
        let firmNo = sender.tag
        FirmDB.currentlyFirmNo = String(firmNo)
        print("firmNO: \(FirmDB.currentlyFirmNo)")
        
        if let firmVC = self.storyboard?.instantiateViewController(withIdentifier: "toHomePageFirmVC") as? HomePageFirmViewController {
            firmVC.transitionBoolFirm = false
            firmVC.modalPresentationStyle = .fullScreen
            self.present(firmVC, animated: true)
          
        }
        else {
            print("View Controller is not found")
        }
        
        
    }


}


