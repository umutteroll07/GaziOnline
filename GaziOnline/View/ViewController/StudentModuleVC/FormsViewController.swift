//
//  FormsViewController.swift
//  GaziOnline
//
//  Created by Umut Erol on 5.03.2024.
//

import UIKit

class FormsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
 
    @IBOutlet weak var collectionView_forms: UICollectionView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSideMenuBtn(menuBtn)

        collectionView_forms.delegate = self
        collectionView_forms.dataSource = self
      
    }
    
    func setSideMenuBtn(_ menuBar : UIBarButtonItem) {
        menuBar.target = revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        
        view.addGestureRecognizer(self.revealViewController()
            .panGestureRecognizer())
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView_forms.dequeueReusableCell(withReuseIdentifier: "toFormCollectionViewCell", for: indexPath) as? FormsCollectionViewCell
        
        cell?.view_collectionViewCell.layer.cornerRadius = 35
        cell?.view_collectionViewCell.clipsToBounds = true
        return cell!
    }

}
