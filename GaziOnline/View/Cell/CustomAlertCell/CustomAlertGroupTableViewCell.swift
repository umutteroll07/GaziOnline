//
//  CustomAlertGroupTableViewCell.swift
//  GaziOnline
//
//  Created by Umut Erol on 15.03.2024.
//

import UIKit

class CustomAlertGroupTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lbl_name: UILabel!

    @IBOutlet weak var tapped_showStudent: UIButton!
    @IBOutlet weak var tapped_showReport: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
 
    

}
