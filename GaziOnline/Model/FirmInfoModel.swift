//
//  FirmInfoModel.swift
//  GaziOnline
//
//  Created by Umut Erol on 18.05.2024.
//

import Foundation
import UIKit

class FirmInfoModel {
    
    let firm_name: String
    let firm_location: String
    let firm_eposta: String
    let firm_logo: String
    let firm_sector: String
    let firm_desc: String
    
    init(firm_name: String, firm_location: String, firm_eposta: String, firm_logo: String, firm_sector: String, firm_desc: String) {
        self.firm_name = firm_name
        self.firm_location = firm_location
        self.firm_eposta = firm_eposta
        self.firm_logo = firm_logo
        self.firm_sector = firm_sector
        self.firm_desc = firm_desc
    }
}

