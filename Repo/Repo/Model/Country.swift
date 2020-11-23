//
//  Country.swift
//  Repo
//
//  Created by Kevin Singh on 22.11.2020.
//

struct CountryItem: Codable {
    var name: String
    var capital: String
    var region: String
    var subregion: String
    var currencies: [Currencies]
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case capital = "capital"
        case region = "region"
        case subregion = "subregion"
        case currencies = "currencies"
    }
}
