//
//  Languages.swift
//  Repo
//
//  Created by Kevin Singh on 23.11.2020.
//

struct Languages: Decodable, Encodable {
    var name: String
    var nativeName: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case nativeName = "nativeName"
    }
}
