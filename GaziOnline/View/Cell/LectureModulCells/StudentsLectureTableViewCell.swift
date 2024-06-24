//
//  StudentsLectureTableViewCell.swift
//  GaziOnline
//
//  Created by Umut Erol on 13.03.2024.
//

import UIKit

class StudentsLectureTableViewCell: UITableViewCell {

    @IBOutlet weak var view_tableViewCell: UIView!
    @IBOutlet weak var txt_studentName: UILabel!
    @IBOutlet weak var tapped_showStudent: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        

    }

    
    
}
