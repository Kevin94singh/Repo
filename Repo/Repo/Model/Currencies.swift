//
//  Currencies.swift
//  Repo
//
//  Created by Kevin Singh on 23.11.2020.
//

struct Currencies: Decodable, Encodable {
    var name: String
    var symbol: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case symbol = "symbol"
    }
}
