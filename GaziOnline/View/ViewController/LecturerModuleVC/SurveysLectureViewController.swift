//
//  SurveysLectureViewController.swift
//  GaziOnline
//
//  Created by Umut Erol on 13.03.2024.
//

import UIKit

class SurveysLectureViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  
    
    
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var collectionView_surveysLecture: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setSideMenuBtn(menuBtn)
        collectionView_surveysLecture.delegate = self
        collectionView_surveysLecture.dataSource = self
        

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
        let cell = collectionView_surveysLecture.dequeueReusableCell(withReuseIdentifier: "toSurveyLectureCVCell", for: indexPath) as? SurveyLectureCollectionViewCell
        
        cell?.view_surveyCollectionView.layer.cornerRadius = 35
        cell?.view_surveyCollectionView.clipsToBounds = true
        
        return cell!
    }
 

}
