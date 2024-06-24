//
//  FirmDB.swift
//  GaziOnline
//
//  Created by Umut Erol on 18.05.2024.
//

import Foundation
import UIKit

class FirmDB {
    
    
 
    
    let connection = ConnectPostgreSql.connection
    static var currentlyFirmNo = String()
    
    var advertFirstInfoModels : [AdvertFirstInfoModel] = []
    
    
    var startDate = String()
    var endDate = String()
    var advertDesc = String()
    var advertTitle = String()
    var postTitle = String()
    
    var firmId = Int()

    
    func fetchFirmInfoFromDatabase() throws -> FirmInfoModel?{
        let query = "SELECT firma_ad , firma_adres , firma_eposta , firma_logo ,firma_sektor , firma_hakkinda FROM firma WHERE firma_no = '\(FirmDB.currentlyFirmNo)'"
        
        do {
            let statement = try connection.prepareStatement(text: query)
            let results = try statement.execute()
            
            for result in results {
                
                let column = try result.get().columns
                let firm_name =  try column[0].string() ?? "-"
                let firm_location = try column[1].string() ?? "-"
                let firm_email = try column[2].string() ?? "-"
                let firm_logo = try column[3].string() ?? "-"
                let firm_sector = try column[4].string() ?? "-"
                let firm_desc = try column[5].string() ?? "-"
    
                let firmModel = FirmInfoModel(firm_name: firm_name, firm_location: firm_location, firm_eposta: firm_email, firm_logo: firm_logo, firm_sector: firm_sector, firm_desc: firm_desc)
                
                return firmModel
                
            }
            
            print("No results found.")
            
        } catch {
            print("Error in fetchFirmInfoFromDatabase: \(error)")
        }
        return nil
    }
    
    
    
    
    func updateFirmDescText(newText:String) {

        let query = "UPDATE firma SET firma_hakkinda = '\(newText)' WHERE firma_no = '\(FirmDB.currentlyFirmNo)'"
        
        do {
            let statement = try connection.prepareStatement(text: query)
            try statement.execute()
            print("Firma hakkında başarı ile güncellendi")
        } catch {
            print("Hata: \(error)")
        }
    }
    
    func fetchFirmIdWithFirmnNo() -> Int {
        let query = "SELECT firma_id FROM firma WHERE firma_no = '\(FirmDB.currentlyFirmNo)'"
        do {
            let statement = try connection.prepareStatement(text: query)
            let results = try statement.execute()
            
            for result in results {
                let columns = try result.get().columns
                firmId = try columns[0].int()
            }
            
            return firmId
        }
        catch{
            print("fetchFirmIdError \(error)")
        }
        
        return firmId
    }
    
    
    func insertAdvertOnPostgreSql(advert : AdvertModel){
        
        
        
        if let advertDesc = advert.advertDesc{
            self.advertDesc = advertDesc
        }
        if let advertTitle = advert.advertTitle{
            self.advertTitle = advertTitle
        }
        if let postTitle = advert.postTitle{
            self.postTitle = postTitle
        }
        
        if let startDate = advert.startDate{
            self.startDate = startDate
        }
        if let endDate = advert.endDate{
            self.endDate = endDate
        }
        
        
        let query = "INSERT INTO ilan (aciklama, baslangic_tarihi, baslik, bitis_tarihi, post_baslik, firma_id) VALUES ('\(self.advertDesc)', '\(self.startDate)', '\(self.advertTitle)', '\(self.endDate)', '\(self.postTitle)', \(advert.firmId))"
        do {
            
            let statement = try connection.prepareStatement(text: query)
            try statement.execute()
            print("insertAdvert is successfully")
            
            
        }catch{
            
            print("insertAdvertError \(error)")
        }
    }
    
    func getAdvertFirstInfoFromPostgre(firmId : Int) -> [AdvertFirstInfoModel] {
        
        let query = "SELECT ilan_id, baslik FROM ilan WHERE firma_id = \(firmId)"
        
        do {
            
            let statement = try connection.prepareStatement(text: query)
            let results = try statement.execute()
            
            for result in results {
                let column = try result.get().columns
                let advertId = try column[0].int()
                let advertTitle = try column[1].string()
                
                let advertFirstInfo = AdvertFirstInfoModel(advertId: advertId, advertTitle: advertTitle)
                
                advertFirstInfoModels.append(advertFirstInfo)
                
            }
            
            return advertFirstInfoModels
            
            
            
        }
        catch{
            print("get advert titles error \(error)")
        }
       
       
        return advertFirstInfoModels
    }
    
    
    

    
    func fetchAdvertInfo(advertId : Int) throws -> AdvertModel? {

        var advertDesc = String()
        var advertStartDate = String()
        var advertTitle = String()
        var advertEndDate = String()
        var advertPostTitle = String()
        var query = "SELECT aciklama, baslangic_tarihi, baslik, bitis_tarihi, post_baslik FROM ilan WHERE ilan_id = \(advertId)"

        do{
            let statement = try connection.prepareStatement(text: query)
            let results = try statement.execute()

            for result in results {
                let column = try result.get().columns
                
                do {
                    advertDesc = try column[0].string()
                }
                catch{
                    advertDesc = "--"
                    print("fetchAdvertInfo error : \(error)")
                }
                do {
                    advertStartDate = try column[1].string()
                }
                catch{
                    advertStartDate = "2024/01/01"
                    print("fetchAdvertInfo error : \(error)")

                }
                do {
                     advertTitle = try column[2].string()
                }
                catch{
                    advertTitle = "--"
                    print("fetchAdvertInfo error : \(error)")

                }
                do {
                    advertEndDate = try column[3].string()
                }
                catch{
                    advertEndDate = "2024/01/01"
                    print("fetchAdvertInfo error : \(error)")

                }
                do {
                    advertPostTitle = try column[4].string()
                }
                catch{
                    advertPostTitle = "nil"
                    print("fetchAdvertInfo error : \(error)")

                }
                
                
                
                
               

                let advertInfo = AdvertModel(advertDesc: advertDesc, advertTitle: advertTitle, postTitle: advertPostTitle, startDate: advertStartDate, endDate: advertEndDate, firmId: firmId)

                return advertInfo
            }
        }
        catch{
            print("fetch advertInfo Error \(error)")
        }
        return nil
    }

    
}
