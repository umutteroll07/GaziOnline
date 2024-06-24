//
//  StudentPersonInfoDB.swift
//  GaziOnline
//
//  Created by Umut Erol on 22.03.2024.
//

import Foundation
import UIKit

class StudentDB{
    
    var studentPsw = String()
    var firmList : [FirmFirstViewInfoModel] = []
    var connection = ConnectPostgreSql.connection
    static var currentlyStudentNoDB = Int()

    func fetchStudentPersonInfo() throws -> StudentPersonInfoModel? {
        let query = "SELECT ogrenci_no, ogrenci_ad, ogrenci_soyad, ogrenci_fakulte, ogrenci_agno, ogrenci_sinif, ogrenci_hakkinda FROM ogrenci WHERE ogrenci_no = \(StudentDB.currentlyStudentNoDB)"
        
        do {
            
            let statement = try connection.prepareStatement(text: query)
            let result = try statement.execute()
            
            
            for row in result {
                let columns = try row.get().columns
                let id = try columns[0].string()
                let name = try columns[1].string()
                let surname = try columns[2].string()
                let studentFaculty = try columns[3].string()
                let studentAgno = try columns[4].string()
                let studentClass = try columns[5].string()
                let studentDesc = try columns[6].string()
                
                
               
                let studentInfo = StudentPersonInfoModel(id:id, name: name, surname: surname, student_faculty: studentFaculty, student_agno: studentAgno, student_class: studentClass, student_desc: studentDesc)
                return studentInfo
                
            }
        }catch{
            print("error fetch data from postgreSql")
        }
        return nil
    }

    
    func insertTalentOnPostgreSql(talentDesc : String , talentLevel : String , ogrenciNo : Int) {
        if self.connection != nil {
            
            NotificationCenter.default.post(name: Notification.Name("TalentInserted"), object: nil)

            print("connection is success")
            let insertQuery = "INSERT INTO yetenek (aciklama, seviye, ogrenci_no) VALUES ('\(talentDesc)', '\(talentLevel)', \(ogrenciNo))"

            
            do {
                let statement =  try connection.prepareStatement(text: insertQuery)
                try statement.execute()
                print("insert is success")
                
            }catch{
                print(error)
            }
            
        }
        else {
            print("connection is failed")
        }
    }
    
    
    
    func fetchTalentsFromPostgreSql() -> [TalentModel] {
        
        var fetchTalents : [TalentModel] = []
        let ogrenciNo = StudentDB.currentlyStudentNoDB
        
        if connection != nil {
            
            let query = "SELECT skill_id, aciklama, seviye FROM yetenek WHERE ogrenci_no = \(ogrenciNo)"
            
            do {
                let statement = try connection.prepareStatement(text: query)
                let results = try statement.execute()
                
                for result in results {
                    let columns = try result.get().columns
                    
                    var skill_id = Int()
                    try skill_id = columns[0].int()
                    let desc = try columns[1].string()
                    let level = try columns[2].string()
                    
                    let talent = TalentModel(skill_id: skill_id, ogrenci_no: ogrenciNo, talent_desc: desc, talent_level: level)
                    fetchTalents.append(talent)
                }
                
                
                
            }catch{
                print(error)
            }
        }
        return fetchTalents
    }

    
    
    
    func deleteTalentFromPostgreSQL(talent_id:Int) {
        if connection != nil {
            let deleteQuery = "DELETE FROM yetenek WHERE skill_id = \(talent_id)"
            
            do {
                let statement = try connection.prepareStatement(text: deleteQuery)
                try statement.execute()
                print("delete is success")
            }
            catch {
                print("delete error \(error)")
            }
        }
        else {
            print("connection is  not found")
        }
    }
    
    func updatePersonInfoFromDatabase(updateDesc: String) {
        if connection != nil {
            let updateQuery = "UPDATE ogrenci SET ogrenci_hakkinda = '\(updateDesc)' WHERE ogrenci_no = \(StudentDB.currentlyStudentNoDB)"
            
            do {
                let statement = try connection.prepareStatement(text: updateQuery)
                try statement.execute()
                print("Öğrenci bilgileri başarıyla güncellendi.")
            } catch {
                print("Hata: \(error)")
            }
        } else {
            print("Bağlantı bulunamadı.")
        }
    }
    
    
    func insertReportOnPostgreSqlDatabase(reportDesc: String){
        
        if connection != nil {
            
            let insertReportQuery = "INSERT INTO haftalik_rapor (rapor_icerigi, ogrenci_no) VALUES ('\(reportDesc)',\(StudentDB.currentlyStudentNoDB))"
            
            do {
                let statement = try connection.prepareStatement(text: insertReportQuery)
                try statement.execute()
                print("insert report is success")
            }
            catch{
                print("insert report is failed \(error)")
            }
            
            
        }
        else {
            print("connection is failed")
        }
    }

    
    
    func fetchReportFromPostgreSql()  -> [ReportModel]{
        
        var fetchReport : [ReportModel] = []
        let studentNo = StudentDB.currentlyStudentNoDB
        
        if connection != nil {
            
            let fetchReportQuery = "SELECT rapor_id, rapor_icerigi FROM haftalik_rapor WHERE ogrenci_no = \(studentNo)"
            
            do {
                let statement = try connection.prepareStatement(text: fetchReportQuery)
                let results = try statement.execute()
                
                for result in results {
                    let columns = try result.get().columns
                    var reportId = Int()
                    reportId =  try columns[0].int()
                    let reportDesc = try columns[1].string()
                    let report = ReportModel(report_id: reportId, reportDesc: reportDesc, reportDate: "01.10.2023", studentNo: studentNo)
               
                    fetchReport.append(report)
                    
                }
                
                print("fetch report is success")
            }
            catch{
                print("fetch report is failed \(error)")
            }
            
            
            return fetchReport
            
        }
        
        return fetchReport
    }
    
    func fetchPassworFromDatabase(student_no : Int) -> String {
        
        let query = "SELECT ogrenci_parola FROM ogrenci WHERE ogrenci_no = \(student_no)"
        
        do {
            
            let statement = try connection.prepareStatement(text: query)
            let results = try statement.execute()
            
            for result in results {
                
                let column = try result.get().columns
                studentPsw = try column[0].string()
              
                
            }
            return studentPsw
            
        }
        catch{
            print("error /fetchPswFromDatabase")
        }
     
        return studentPsw
    }
    
    
    func updatePasswordStudent(newParola:String) {
        
        let query = "UPDATE ogrenci SET ogrenci_parola = '\(newParola)' WHERE ogrenci_no = \(StudentDB.currentlyStudentNoDB)"
        
        do {
            let statement = try connection.prepareStatement(text: query)
            try statement.execute()
            print("Öğrenci parola başarıyla güncellendi.")
        } catch {
            print("Hata: \(error)")
        }
    }
        
    
    
    

    func updateReportText(reportId : Int , newReportText : String){
        
        let query = "UPDATE haftalik_rapor SET rapor_icerigi = '\(newReportText)' WHERE rapor_id = \(reportId)"
        
        do {
            let statement = try connection.prepareStatement(text: query)
            try statement.execute()
        }
        catch{
            print("error / updateReportText")
        }

        
        
    }
        
    
    
    func fetchFirm_forStudents() -> [FirmFirstViewInfoModel]{
        
        let query = "SELECT firma_no , firma_ad , firma_logo FROM firma"
        
        do{
            let statement = try connection.prepareStatement(text: query)
            let results = try statement.execute()
            
            for result in results {
                
                let column = try result.get().columns
                let firm_no = try column[0].string()
                let firm_name = try column[1].string()
                let firm_logo = try column[2].string()
                
                let firmFirstView = FirmFirstViewInfoModel(firm_no: firm_no, firm_name: firm_name, firm_logo: firm_logo)
                self.firmList.append(firmFirstView)
                
                
            
            }
            return firmList
        }
        catch{
            print("fetchFirmError \(error)")
        }
        
        return firmList
        
    }
    
    
}
