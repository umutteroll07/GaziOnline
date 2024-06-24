//
//  LecturerDBAccess.swift
//  GaziOnline
//
//  Created by Umut Erol on 11.05.2024.
//

import Foundation
import UIKit


class LecturerDBAccess{
    
    var passwordCorrect = Bool()
    
    let connection = ConnectPostgreSql.connection
    
    
    func signIn_forLecturer(lecturerNo : Int , lecturerPsw : String) {
        
        do {
            let passwordQuery =  "SELECT COUNT(*) FROM izleyici WHERE izleyici_id = \(lecturerNo) AND izleyici_parola = '\(lecturerPsw)'"
            let passwordStatement =  try connection.prepareStatement(text: passwordQuery)
            let passwordCursor =  try passwordStatement.execute()
            
            passwordCorrect = false
            for passwordRow in passwordCursor {
                let count =  try passwordRow.get().columns[0].int()
                if count > 0 {
                    
                    
                    passwordCorrect = true
                    LecturerDB.currentlyLecturer = lecturerNo
                    break
                    
                }
            }
            
        }
        catch{
            print("lecturer sign in failed")
        }
        
    }
    
    
}
