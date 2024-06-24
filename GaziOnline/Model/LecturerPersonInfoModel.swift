//
//  LecturerPersonInfoModel.swift
//  GaziOnline
//
//  Created by Umut Erol on 13.05.2024.
//

import Foundation
import UIKit

class LecturerPersonInfoModel {
    
    let lecturerName : String
    let lecturerSurname : String
    let lecturerEposta : String
    let lecturerPassword : String
    
 
    init(lecturerName: String, lecturerSurname: String, lecturerEposta: String, lecturerPassword: String) {
           self.lecturerName = lecturerName
           self.lecturerSurname = lecturerSurname
           self.lecturerEposta = lecturerEposta
           self.lecturerPassword = lecturerPassword
       }
    
    
}
