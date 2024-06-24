//
//  SurveyViewController.swift
//  GaziOnline
//
//  Created by Umut Erol on 11.03.2024.
//

import UIKit

class SurveyViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var collectionView_survey: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSideMenuBtn(menuBtn)
        
        collectionView_survey.delegate = self
        collectionView_survey.dataSource = self


        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "toSurveyCollectionViewCell", for: indexPath) as? SurveyCollectionViewCell
        cell?.view_collectionViewCell.layer.cornerRadius = 35
        cell?.view_collectionViewCell.clipsToBounds = true
  


        return cell!
    }
    
    

   

}
