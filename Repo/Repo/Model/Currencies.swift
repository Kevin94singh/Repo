//
//  Currencies.swift
//  Repo
//
//  Created by Kevin Singh on 23.11.2020.
//

struct Currencies: Decodable, Encodable {
    var name: String
    var code: String
    var symbol: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case code = "code"
        case symbol = "symbol"
    }
}
