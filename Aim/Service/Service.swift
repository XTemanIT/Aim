//
//  Service.swift
//  NewAim
//
//  Created by Artem Sierokurov on 22.10.2021.
//
import Foundation

let url = "https://2llctw8ia5.execute-api.us-west-1.amazonaws.com/prod"


struct Service {
    
    static let sharedInst = Service()
    
    func getData(from url: String) {
            URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            guard let data = data, error == nil else { return }
            var result: MyResults?
            do {
                result = try JSONDecoder().decode(MyResults.self, from: data)
            }
            catch {  }
            guard let json = result else { return }
                let dictGet = ["winner":json.winner, "loser":json.loser]
                NotificationCenter.default.post(name: Notification.Name("Get"), object: nil, userInfo: dictGet)
            }).resume()
    }
}

struct MyResults: Codable {
    let winner: String
    let loser: String
}

