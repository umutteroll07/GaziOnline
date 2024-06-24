//
//  FirmViewController.swift
//  GaziOnline
//
//  Created by Umut Erol on 2.03.2024.
//

import UIKit

class FirmViewController: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource{
  

    var firmList : [FirmFirstViewInfoModel] = []
    
    @IBOutlet weak var collectionViewFirm: UICollectionView!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    let studentDB = StudentDB()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firmList = studentDB.fetchFirm_forStudents()
        
        self.setSideMenuBtn(menuBtn)
        collectionViewFirm.delegate = self
        collectionViewFirm.dataSource = self
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
        let cell = collectionViewFirm.dequeueReusableCell(withReuseIdentifier: "toFirmCollectionViewCell", for: indexPath) as? FirmCollectionViewCell
        // Cell styling
        cell?.view_collectionViewCell.layer.cornerRadius = 10
        cell?.view_collectionViewCell.layer.borderWidth = 1
        cell?.view_collectionViewCell.layer.borderColor = UIColor.lightGray.cgColor
        cell?.view_collectionViewCell.layer.shadowColor = UIColor.black.cgColor
        cell?.view_collectionViewCell.layer.shadowOpacity = 0.2
        cell?.view_collectionViewCell.layer.shadowOffset = CGSize(width: 3, height: 3)
        cell?.view_collectionViewCell.layer.shadowRadius = 4
        cell?.view_collectionViewCell.layer.masksToBounds = false

        cell?.lbl_firmName.layer.cornerRadius = 5
        cell?.lbl_firmName.layer.borderWidth = 1
        cell?.lbl_firmName.layer.borderColor = UIColor.lightGray.cgColor
        cell?.lbl_firmName.layer.shadowColor = UIColor.black.cgColor
        cell?.lbl_firmName.layer.shadowOpacity = 0.2
        cell?.lbl_firmName.layer.shadowOffset = CGSize(width: 3, height: 3)
        cell?.lbl_firmName.layer.shadowRadius = 4
        cell?.lbl_firmName.layer.masksToBounds = true
        
        

        cell?.view_collectionViewCell.layer.cornerRadius = 35
        cell?.view_collectionViewCell.clipsToBounds = true
        
        let imageUrl = firmList[indexPath.row].firm_logo
        if let url = URL(string: imageUrl) {
            cell?.image_firm.loadImageFirmLogo(from: url)
        }
        cell?.lbl_firmName.text = firmList[indexPath.row].firm_name
        
        
        
        cell?.btn_view_apply.tag = Int(firmList[indexPath.row].firm_no)!
        cell?.btn_view_apply.addTarget(self, action: #selector(clicked_view_apply_btn), for: .touchUpInside)

        
        
 
        
        
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

extension  UIImageView {
    
    func loadImageFirmLogo(from url: URL) {
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

