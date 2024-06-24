//
//  AdvertsViewController.swift
//  GaziOnline
//
//  Created by Umut Erol on 25.05.2024.
//

import UIKit

class AdvertsFirmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var tapped_addAdvert: UIBarButtonItem!
    @IBOutlet weak var tableView_advertsForFirm: UITableView!
    
    
    var advertFirstInfoList : [AdvertFirstInfoModel]  = []
    var firmId = Int()
    let firmDB = FirmDB()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView_advertsForFirm.delegate = self
        tableView_advertsForFirm.dataSource = self
        
        self.setSideMenuBtn(menuBtn)
        tapped_addAdvert.target = self
        tapped_addAdvert.action = #selector(clicked_addAdvertBtn)
        
        // Hücreler arasına çizgi eklemek için separator özelliklerini ayarlayın
        tableView_advertsForFirm.separatorStyle = .singleLine
        tableView_advertsForFirm.separatorColor = UIColor.black
        
        
        
        firmId = firmDB.fetchFirmIdWithFirmnNo()
        advertFirstInfoList = firmDB.getAdvertFirstInfoFromPostgre(firmId: firmId)
    

    }
    
    func setSideMenuBtn(_ menuBar : UIBarButtonItem) {
        menuBar.target = revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        
        view.addGestureRecognizer(self.revealViewController()
            .panGestureRecognizer())
        
    }

    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return advertFirstInfoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView_advertsForFirm.dequeueReusableCell(withIdentifier: "toAdvertFirmCell") as?
        AdvertsFirmTableViewCell
        
        let separatorLineView = UIView(frame: CGRect(x: 0, y: cell!.frame.size.height - 1, width: cell!.frame.size.width, height: 1))
        separatorLineView.backgroundColor = UIColor.black
        cell!.addSubview(separatorLineView)
      
        cell?.lbl_advertName.text = "\(advertFirstInfoList[indexPath.row].advertTitle)"
        
        cell?.tapped_editAdvertBtn.tag = advertFirstInfoList[indexPath.row].advertId
        cell?.tapped_editAdvertBtn.addTarget(self, action: #selector(clicked_editAdvertBtn), for: .touchUpInside)

        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    @objc func clicked_addAdvertBtn(){
        let addAdvertVC = self.storyboard?.instantiateViewController(identifier: "toAddAdvertVC") as? AddorUpdateAdvertViewController
        
        addAdvertVC?.transitionBool = false
        self.navigationController?.pushViewController(addAdvertVC!, animated: true)
    }
    
    
    
    @objc func clicked_editAdvertBtn(_ sender: UIButton) {
        
        let transitionBool = true

        let advertInfoVC = self.storyboard?.instantiateViewController(identifier: "toAddAdvertVC") as? AddorUpdateAdvertViewController

        advertInfoVC?.transitionBool = transitionBool
        
        let advert_id = sender.tag
        do {
            let advertModel = try firmDB.fetchAdvertInfo(advertId: advert_id)

            if let advertDesc = advertModel?.advertDesc {
                advertInfoVC?.advertDescString = advertDesc
            }
            
            if let advertTitle = advertModel?.advertTitle {
                advertInfoVC?.advertTitleString = advertTitle
            }
            if let postTitle = advertModel?.postTitle{
                advertInfoVC?.advertPostTitleString = postTitle
            }
            if let advertStartDate = advertModel?.startDate {
                advertInfoVC?.advertStartDateString = advertStartDate
            }
            if let advertEndDate = advertModel?.endDate {
                advertInfoVC?.advertEndDateString = advertEndDate
            }

        
            
            self.navigationController?.pushViewController(advertInfoVC!, animated: true)
        }
        catch{
            print(error)
        }
        


    }

}
