import Foundation

class StationCellViewModel {
    var id: String
    var name: String
    var address: String
    var numBikesAvailable: String
    var numDocksAvailable: String
    
    init(station: Station, status: Status?) {
        self.id = station.stationID
        self.name = station.name
        self.address = station.address
        guard let status = status else {
            self.numBikesAvailable = "-"
            self.numDocksAvailable = "-"
            return
        }
        self.numBikesAvailable = String(status.numBikesAvailable)
        self.numDocksAvailable = String(status.numDocksAvailable)
    }
}
