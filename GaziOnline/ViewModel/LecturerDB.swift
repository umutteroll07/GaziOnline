//
//  LecturerDB.swift
//  GaziOnline
//
//  Created by Umut Erol on 11.05.2024.
//

import Foundation
import UIKit

class LecturerDB{
    
    var lecturerPsw = String()
    
    var groupID_list : [Int] = []
    let connection = ConnectPostgreSql.connection
    var studentList : [StudentPersonInfoModel] = []
    var studentInGroupList : [Int] = []
    var fetchStudentNameWithId_forGroup = String()
    
    static var currentlyLecturer = Int()
    
    func fetchStudent_forLecturer() -> [StudentPersonInfoModel]{
        let query = "SELECT ogrenci_no, ogrenci_ad, ogrenci_soyad, ogrenci_fakulte, ogrenci_agno, ogrenci_sinif, ogrenci_hakkinda FROM ogrenci"
        do {
            let statement = try connection.prepareStatement(text: query)
            let results =  try statement.execute()
            
            
            for result in results {
                
                let columns = try result.get().columns
                let id = try columns[0].string()
                let name = try columns[1].string()
                let surname = try columns[2].string()
                let studentFaculty = try columns[3].string()
                let studentAgno = try columns[4].string()
                let studentClass = try columns[5].string()
                let studentDesc = try columns[6].string()
                
                
                 let studentInfo = StudentPersonInfoModel(id:id, name: name, surname: surname, student_faculty: studentFaculty, student_agno: studentAgno, student_class: studentClass, student_desc: studentDesc)
                
                studentList.append(studentInfo)
                
            }
            
        }
        catch {
            print("FETCH student for lecturer failed")
        }
        
        return studentList
    }
    
    
    func fetchGroup_forLecturer() -> [Int]{
        let query = "SELECT grup_id FROM ogrenci_grup WHERE izleyici_id = \(LecturerDB.currentlyLecturer)"
        
        do {
            let statement = try connection.prepareStatement(text: query)
            let results = try statement.execute()
            
            
            for result in results {
                let columns = try result.get().columns
                let group_id = try columns[0].string()
                if let groupId_append = Int(group_id){
                    groupID_list.append(groupId_append)
                }
            }
        }
        catch{
            print(error)
        }
        
        return groupID_list
        
    }
    
    func fetchStudentInGroup(groupId : Int) -> [Int] {
        
        let query = "SELECT ogrenci_no FROM gruptaki_ogrenciler WHERE grup_id = \(groupId)"
        
        do {
            
            let statement = try connection.prepareStatement(text: query)
            let results = try statement.execute()
            
            for result in results {
                let column = try result.get().columns
                let studentInGroup = try column[0].string()
                if let studentInGroupAppend = Int(studentInGroup){
                    studentInGroupList.append(studentInGroupAppend)
                }
                
                
            }
            
            
        }
        catch {
            print("error /fetchStudentFromGroup")
        }
        
        return studentInGroupList
    }
    
    
    
    func fetchStudentNameWithIdForGroup(studentId:Int) -> String{
        let query = "SELECT ogrenci_ad , ogrenci_soyad FROM ogrenci WHERE ogrenci_no = \(studentId)"
        
        do {
            let statement = try connection.prepareStatement(text: query)
            let results = try statement.execute()
            
            for result in results {
                
                let column = try result.get().columns
                self.fetchStudentNameWithId_forGroup = "\(try column[0].string()) \(try column[1].string())"
                
            }
            
            
        }
        catch{
            print("error /fetchStudentNameWithIdForGroup")
        }
        
        return fetchStudentNameWithId_forGroup
    }
    
    
    
    func fetchLecturerPersonInfo() throws -> LecturerPersonInfoModel?  {
        
        let query = "SELECT izleyici_ad , izleyici_soyad , izleyici_eposta , izleyici_parola FROM izleyici WHERE izleyici_id = \(LecturerDB.currentlyLecturer)"
        
        do {
            let statement =  try connection.prepareStatement(text: query)
            let results = try statement.execute()
            
            
            for result in results {
                
                let column = try result.get().columns
                let lecturerName = try column[0].string()
                let lecturerSurname =  try column[1].string()
                let lecturerEposta = try column[2].string()
                let lecturerPassword = try column[3].string()
                
                let lecturerInfo = LecturerPersonInfoModel(lecturerName: lecturerName, lecturerSurname: lecturerSurname, lecturerEposta: lecturerEposta, lecturerPassword: lecturerPassword)
                
                return lecturerInfo
                
             
                
                
            }
        }
        catch{
            print("error /fetchLecturerPersonInfo")
        }
        
        return nil
        
    }
    
    func fetchPassworFromDatabase(izleyici_no : Int) -> String {
        
        let query = "SELECT izleyici_parola FROM izleyici WHERE izleyici_id = \(izleyici_no)"
        
        do {
            
            let statement = try connection.prepareStatement(text: query)
            let results = try statement.execute()
            
            for result in results {
                
                let column = try result.get().columns
                lecturerPsw = try column[0].string()
              
                
            }
            return lecturerPsw
            
        }
        catch{
            print("error /fetchPswFromDatabase")
            print(error)
        }
     
        return lecturerPsw
    }

    
    func updatePasswordStudent(newParola:String) {
        
        let query = "UPDATE izleyici SET izleyici_parola = '\(newParola)' WHERE izleyici_id = \(LecturerDB.currentlyLecturer)"
        
        do {
            let statement = try connection.prepareStatement(text: query)
            try statement.execute()
            print("İzleyici parola başarıyla güncellendi.")
        } catch {
            print("Hata: \(error)")
        }
    }
    
    
    
}
