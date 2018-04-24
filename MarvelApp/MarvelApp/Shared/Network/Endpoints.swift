//
//  Endpoints.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 19/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import Foundation

extension Date {
    func toMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}

struct Endpoints {
    var path: String
    let params: [String: String]
    let baseURL = "https://gateway.marvel.com:443"
    let publicKey = "2dbf639c74260d760a42699644cf1dc9"
    let privateKey = "7bfa50912605d2addf774eec141fde7c6b2d0779"
    let timeStamp = "\(Date().toMillis())"
}

extension Endpoints {
    
    fileprivate func generateParams() -> String {
        var newParams = self.params
        newParams["apikey"] = self.publicKey
        newParams["hash"] = self.hash()
        newParams["ts"] = self.timeStamp
        
        let itemsForJoin = newParams.compactMap { (key, value) -> String? in
            let encodedValue = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? value
            return "\(key)=\(encodedValue)"
        }
        let joinedValues = itemsForJoin.joined(separator: "&")
        return "?\(joinedValues)"
    }
    
    func generateURL() -> URL? {
        let cleanerPath = self.path.replacingOccurrences(of: "http://gateway.marvel.com", with: "")
        return URL(string: "\(baseURL)\(cleanerPath)\(generateParams())")
    }
    
    func hash() -> String {
        let md5 = MD5(string: "\(self.timeStamp)\(self.privateKey)\(self.publicKey)")
        return md5.map { String(format: "%02hhx", $0) }.joined()
    }
    
    private func MD5(string: String) -> Data {
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        return digestData
    }

}
