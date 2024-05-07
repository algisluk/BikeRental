import Foundation

class StationDetailsViewModel {
    
    var stationData: StationCellViewModel
    
    var id: String
    var name: String
    var address: String
    var numBikesAvailable: String
    var numDocksAvailable: String
    var lat: Double
    var lon: Double
    
    init(station: StationCellViewModel, lat: Double, lon: Double) {
        self.stationData = station
        
        self.id = station.id
        self.name = station.name
        self.address = station.address
        self.numBikesAvailable = station.numBikesAvailable
        self.numDocksAvailable = station.numDocksAvailable
        self.lat = lat
        self.lon = lon
    }
    
}
