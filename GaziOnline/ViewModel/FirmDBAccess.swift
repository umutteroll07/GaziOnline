//
//  FirmDBAccess.swift
//  GaziOnline
//
//  Created by Umut Erol on 18.05.2024.
//

import Foundation
import UIKit


class FirmDBAccess{
    
    
    var passwordCorrect = Bool()
    var currentlyFirmNo = String()
    
    let connection =  ConnectPostgreSql.connection
    func signIn_forFirm(firmNo : String , firmPassword : String) {
        
        do {
            let passwordQuery = "SELECT COUNT(*) FROM firma WHERE firma_no = '\(firmNo)' AND firma_parola = '\(firmPassword)'"
            let statement = try connection.prepareStatement(text: passwordQuery)
            let results = try statement.execute()
            
            passwordCorrect = false
            for result in results {
                let count = try result.get().columns[0].int()
                if count > 0 {
                    currentlyFirmNo = firmNo
                    FirmDB.currentlyFirmNo = currentlyFirmNo
                    passwordCorrect = true
                    break
                }
            }
            
            

        }
        catch{
            print("error / firmSignIn \(error)")
        }
        
    }
    
    
}
