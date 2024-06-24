import Foundation
import UIKit
import PostgresClientKit

class ConnectPostgreSql {
    
    static var connection = connectAndFetchData()
    
    static func connectAndFetchData() -> PostgresClientKit.Connection {
        
        var connectionFetch : PostgresClientKit.Connection!
        do {
            
                var configuration = PostgresClientKit.ConnectionConfiguration()
                configuration.host = "localhost"
                configuration.ssl = false
                configuration.port = 5432
                configuration.database = "GaziOnlinePostgreSQL"
                configuration.user = "postgres"
                configuration.credential = .scramSHA256(password: "admin")
                
                connectionFetch = try PostgresClientKit.Connection(configuration: configuration)
            

//            guard let connectionFetch = connection else {
//                print("Bağlantı oluşturulamadı.")
//                return
//            }

        } catch {
            print(error)
        }
       
    
        return connectionFetch
    }
}
