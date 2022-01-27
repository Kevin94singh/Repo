struct Name: Codable {
    var common: String
    var official: String
    
    enum CodingKeys: String, CodingKey {
        case common = "common"
        case official = "official"
    }
}
