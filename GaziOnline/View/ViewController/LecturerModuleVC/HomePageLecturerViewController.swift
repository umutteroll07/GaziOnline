//
//  SupervizorHomePagaViewController.swift
//  GaziOnline
//
//  Created by Umut Erol on 11.03.2024.
//

import UIKit

class HomePageLecturerViewController: UIViewController {
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setSideMenuBtn(menuBtn)

    }
    

    
    func setSideMenuBtn(_ menuBar : UIBarButtonItem) {
        menuBar.target = revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        
        view.addGestureRecognizer(self.revealViewController()
            .panGestureRecognizer())
        
    }
    

}
