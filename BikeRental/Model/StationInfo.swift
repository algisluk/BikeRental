import Foundation

struct StationInfo: Codable {
    let data: DataClass

    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct DataClass: Codable {
    let stations: [Station]
}

struct Station: Codable {
    let stationID, name, address, crossStreet: String
    let lat, lon: Double

    enum CodingKeys: String, CodingKey {
        case stationID = "station_id"
        case name, address
        case crossStreet = "cross_street"
        case lat, lon
    }
}
