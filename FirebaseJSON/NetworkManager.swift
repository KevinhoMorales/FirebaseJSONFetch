//
//  NetworkManager.swift
//  NetworkManagerJSONSample
//
//  Created by Kevinho Morales on 22/11/20.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol NetworkManagerDataResource {
    func getDataFromServer(data: [Users])
}

class NetworkManager {
    
    var arrayUsers = [Users]()
    var users: Users?
    // PROPIEDAD DEL PROTOCOLO
    let delegate: NetworkManagerDataResource
    
    init(delegate: NetworkManagerDataResource) {
        self.delegate = delegate
    }
    
    func downloadDataFromAPI(){
        AF.request("https://firestore.googleapis.com/v1/projects/flyectravelapp/databases/(default)/documents/prod/travels/users").responseJSON { [self] response in
            switch response.result {
            case .success(let value):
                let myResult = try? JSON(data: response.data!)
    //                print(myResult!["documents"])
                let documents = myResult!["documents"]
                for i in documents.arrayValue {
    //                    print(i)
    //                    let name = i["name"].stringValue
                    let field = i["fields"].dictionaryValue
                    let from = field["from"]!.dictionaryValue
                    let stringValueFrom = from["stringValue"]!.stringValue
                    
                    let to = field["to"]!.dictionaryValue
                    let stringValueTo = to["stringValue"]!.stringValue
                    
                    let user = Users(documents: [Documents(name: "", fields: Fields(from: From(stringValue: stringValueFrom), to: To(stringValue: stringValueTo)), createTime: "", updateTime: "")])
                    arrayUsers.append(user)
                    delegate.getDataFromServer(data: arrayUsers)
                }
            case .failure(let error):
                print("El nuevo error -> \(error.localizedDescription)")
            }
        }
    }
    
}


