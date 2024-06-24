//
//  StudentsFirmsTableViewCell.swift
//  GaziOnline
//
//  Created by Umut Erol on 13.03.2024.
//

import UIKit

class StudentsFirmsTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var view_tableViewCell: UIView!
    @IBOutlet weak var lbl_nameStudent: UILabel!
    @IBOutlet weak var tapped_showStudent: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func clicked_showStudent(_ sender: Any) {
    }
    
    
}
