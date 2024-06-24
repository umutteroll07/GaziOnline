//
//  AdvertModel.swift
//  GaziOnline
//
//  Created by Umut Erol on 28.05.2024.
//

import Foundation


struct AdvertModel{
    
    let advertDesc : String?
    let advertTitle : String?
    let postTitle : String?
    let startDate : String?
    let endDate : String?
    let firmId : Int
    
    
    // Custom initializer
      init(advertDesc: String, advertTitle: String, postTitle: String, startDate: String, endDate: String, firmId: Int) {
          self.advertDesc = advertDesc
          self.advertTitle = advertTitle
          self.postTitle = postTitle
          self.startDate = startDate
          self.endDate = endDate
          self.firmId = firmId
      }
    
}
