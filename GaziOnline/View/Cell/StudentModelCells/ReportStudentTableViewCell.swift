//
//  ReportStudentTableViewCell.swift
//  GaziOnline
//
//  Created by Umut Erol on 17.03.2024.
//

import UIKit

class ReportStudentTableViewCell: UITableViewCell {


    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var lbl_reportText: UITextView!
    
    
    @IBOutlet weak var tapped_updateBtn: UIButton!
    @IBOutlet weak var tapped_editReport: UIButton!
    @IBOutlet weak var tapped_deleteReport: UIButton!
}
