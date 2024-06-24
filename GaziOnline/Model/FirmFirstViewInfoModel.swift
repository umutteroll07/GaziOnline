import Foundation

class FirmFirstViewInfoModel {
    
    var firm_no: String
    var firm_name: String
    var firm_logo: String
    
    // Başlatıcı (initializer)
    init(firm_no: String, firm_name: String, firm_logo: String) {
        self.firm_no = firm_no
        self.firm_name = firm_name
        self.firm_logo = firm_logo
    }
}

