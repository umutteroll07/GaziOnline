//
//  HomePageViewController.swift
//  GaziOnline
//
//  Created by Umut Erol on 2.03.2024.
//

import UIKit

class HomePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var favBtn: UIBarButtonItem!
    @IBOutlet weak var tableView_postView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSideMenuBtn(menuBtn)
        
        tableView_postView.delegate = self
        tableView_postView.dataSource = self
        
        
    }
    
    
    func setSideMenuBtn(_ menuBar : UIBarButtonItem) {
        menuBar.target = revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        
        view.addGestureRecognizer(self.revealViewController()
            .panGestureRecognizer())
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 560
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView_postView.dequeueReusableCell(withIdentifier: "toPostTVCell") as? PostViewTableViewCell
        // Hücrenin alt boşluğunu ayarlayarak çizgi oluştur
        let separatorLine = UIView(frame: CGRect(x: 0, y: cell!.frame.height - 1, width: cell!.frame.width, height: 1))
        separatorLine.backgroundColor = UIColor.lightGray // Çizgi rengini ayarlayabilirsiniz
        cell!.addSubview(separatorLine)
        return cell!
    }
    


}
