import Foundation

struct StationStatus: Codable {
    let data: StatusData

    enum CodingKeys: String, CodingKey {
        case data
    }
}

struct StatusData: Codable {
    let stations: [Status]
}

struct Status: Codable {
    let stationID: String
    let numVehiclesAvailable, numBikesAvailable, numDocksAvailable: Int

    enum CodingKeys: String, CodingKey {
        case stationID = "station_id"
        case numVehiclesAvailable = "num_vehicles_available"
        case numBikesAvailable = "num_bikes_available"
        case numDocksAvailable = "num_docks_available"
    }
}
