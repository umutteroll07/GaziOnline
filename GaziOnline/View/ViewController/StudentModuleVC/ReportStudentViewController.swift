//
//  ReportStudentViewController.swift
//  GaziOnline
//
//  Created by Umut Erol on 17.03.2024.
//

import UIKit

class ReportStudentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , ReportCustomAlertDialog{
  

    
    var transitionBoolReport = true

    
    var reportList : [ReportModel] = []
    var reportId = Int()
    let studentDB = StudentDB()
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var tableView_report: UITableView!
    @IBOutlet weak var lbl_titleReport: UILabel!
    @IBOutlet weak var tapped_addReport: UIButton!
    @IBOutlet weak var back_btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        getReport()

        
        self.setSideMenuBtn(menuBtn)
        tableView_report.delegate = self
        tableView_report.dataSource = self
        
        if transitionBoolReport {
            lbl_titleReport.isHidden = true
            tapped_addReport.isHidden = false
            tapped_addReport.isEnabled = true
            back_btn.isHidden = true
            back_btn.isEnabled = false
            tapped_addReport.addTarget(self, action: #selector(tapped_addReportBtn), for: .touchUpInside)
        }
        else {
            lbl_titleReport.isHidden = false
            tapped_addReport.isHidden = true
            tapped_addReport.isEnabled = false
            back_btn.isHidden = false
            back_btn.isEnabled = true
            back_btn.addTarget(self, action: #selector(tapped_backBtn), for: .touchUpInside)
            
        }

    }
    
    
    func setSideMenuBtn(_ menuBar : UIBarButtonItem) {
        menuBar.target = revealViewController()
        menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
        
        if self.transitionBoolReport {
            view.addGestureRecognizer(self.revealViewController()
                .panGestureRecognizer())
        }
       
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView_report.dequeueReusableCell(withIdentifier: "toReportVCCell") as? ReportStudentTableViewCell
        
        
        
        cell?.tapped_editReport.addTarget(self, action: #selector(tappedEditReportBtn), for: .touchUpInside)
        cell?.tapped_deleteReport.addTarget(self, action: #selector(tappedDeleteReportBtn), for: .touchUpInside)
        
        if (!transitionBoolReport) {
            cell?.tapped_deleteReport.isEnabled = false
            cell?.tapped_deleteReport.isHidden = true
            cell?.tapped_editReport.isEnabled = false
            cell?.tapped_editReport.isHidden = true
        }
        
        // reportList dizisini reportId'ye göre sırala
        reportList.sort { $0.report_id < $1.report_id }

        cell?.lbl_reportText.text = reportList[indexPath.row].reportDesc
        cell?.lbl_date.text = reportList[indexPath.row].reportDate
        reportId = reportList[indexPath.row].report_id
        
        
        
        return cell!
    }
    
  
    @objc func tapped_addReportBtn() {
        let customAlert = self.storyboard?.instantiateViewController(withIdentifier: "toReportAlertDialogVC") as?
        ReportCustomAlertViewController
        
        
        customAlert?.delegate = self
        customAlert?.modalPresentationStyle = .overCurrentContext
        customAlert?.providesPresentationContextTransitionStyle = true
        customAlert?.definesPresentationContext = true
        customAlert?.modalTransitionStyle = .crossDissolve
        self.present(customAlert!, animated: true)
    }
    
    
    
    func getReport() {
        self.reportList = studentDB.fetchReportFromPostgreSql()
       
    }
    
    @objc func tapped_backBtn(){
        self.dismiss(animated: true)
    }
    

    
    @objc func tappedEditReportBtn(sender: UIButton) {
        guard let cell = sender.superview?.superview as? ReportStudentTableViewCell,
              let indexPath = tableView_report.indexPath(for: cell) else {
            return
        }

        // Seçili hücrenin rapor ID'sini al
        let selectedReportId = reportList[indexPath.row].report_id
        print("Selected Report ID: \(selectedReportId)")

        // Diğer işlemleri burada yapabilirsiniz
      
        tapped_addReport.isHidden = true
        tapped_addReport.isEnabled = false
        
        cell.tapped_editReport.isHidden = true
        cell.tapped_editReport.isEnabled = false
        cell.tapped_deleteReport.isHidden = true
        cell.tapped_deleteReport.isEnabled = false
        cell.tapped_updateBtn.isHidden = false
        cell.tapped_updateBtn.isEnabled = true
        cell.tapped_updateBtn.addTarget(self, action: #selector(tappedUpdateBtn), for: .touchUpInside)
        
        cell.lbl_reportText.isEditable = true
    }



 
    @objc func tappedUpdateBtn(sender: UIButton) {
        // Tıklanan butona ait olduğu hücreyi bul
        guard let cell = sender.superview?.superview as? ReportStudentTableViewCell,
              let indexPath = tableView_report.indexPath(for: cell),
              let newReportText = cell.lbl_reportText.text else {
            return
        }
        
        
        // Seçili hücrenin rapor ID'sini al
        let reportId = reportList[indexPath.row].report_id
        
        
        studentDB.updateReportText(reportId: reportId, newReportText: newReportText)
        
        // Bildirim göster
        showToast(message: "Rapor güncellendi.")
        
        // UITextView'in editable özelliğini false yap
        cell.lbl_reportText.isEditable = false
        
        // Güncelleme butonunu gizle
        sender.isHidden = true
        sender.isEnabled = false
        
        cell.tapped_editReport.isHidden = false
        cell.tapped_editReport.isEnabled = true
        cell.tapped_deleteReport.isHidden = false
        cell.tapped_deleteReport.isEnabled = true
        
        // Ekleme butonunu görünür hale getir
        tapped_addReport.isHidden = false
        tapped_addReport.isEnabled = true
    }


    
    @objc func tappedDeleteReportBtn() {
        print("tapped delete report btn")
    }
    
    
    func showToast(message: String) {
           let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
           toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
           toastLabel.textColor = UIColor.white
           toastLabel.textAlignment = .center
           toastLabel.font = UIFont.systemFont(ofSize: 12)
           toastLabel.text = message
           toastLabel.alpha = 1.0
           toastLabel.layer.cornerRadius = 10
           toastLabel.clipsToBounds = true
           self.view.addSubview(toastLabel)
           UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
               toastLabel.alpha = 0.0
           }, completion: {(isCompleted) in
               toastLabel.removeFromSuperview()
           })
       }
    
    func CancelButtonTapped() {
        
    }
    
        
         
        
    


}
