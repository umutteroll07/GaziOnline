//
//  StudentDBAccess.swift
//  GaziOnline
//
//  Created by Umut Erol on 21.03.2024.
//

import Foundation
import UIKit

class StudentDBAccess{
                
    var studentExists = Bool()
    var passwordCorrect = Bool()
    var currentlyStudentNo = Int()
    
    

    let connection = ConnectPostgreSql.connection
    func signIn_forStudent(studentNumber: Int, password: String) {
        
          do {
           
                  let passwordQuery = "SELECT COUNT(*) FROM ogrenci WHERE ogrenci_no = \(studentNumber) AND ogrenci_parola = '\(password)'"
                  let passwordStatement = try connection.prepareStatement(text: passwordQuery)
                  defer { passwordStatement.close() }
                  let passwordCursor = try passwordStatement.execute()
                  defer { passwordCursor.close() }
                  
                  passwordCorrect = false
                  for passwordRow in passwordCursor {
                      let count = try passwordRow.get().columns[0].int()
                      if count > 0 {
                          currentlyStudentNo = studentNumber
                          StudentDB .currentlyStudentNoDB = currentlyStudentNo
                          print("acces cNo: \(currentlyStudentNo) ")
                          passwordCorrect = true
                          break
                      }
                  }
                  
          } catch {
              print(error)
          }
    }
    

}

