import Foundation

class StationsViewModel {
    
    private var apiService: APIService!
    private var locationService: LocationService!
    
    var isLoadingData: Observable<Bool> = Observable(false)
    var dataSource: StationInfo?
    var stations: Observable<[StationCellViewModel]> = Observable(nil)
    
    init(apiService: APIService = APIService(), locationService: LocationService = LocationService()) {
        self.apiService = apiService
        self.locationService = locationService
    }
    
    func fetchData() {
        if isLoadingData.value ?? true {
            return
        }
        
        isLoadingData.value = true
        self.apiService.apiToGetStationsData{ [weak self] result in
            switch result {
            case .success(let data):
                self?.dataSource = data
                self?.apiService.apiToGetStationsDetailsData{ [weak self] result in
                    self?.isLoadingData.value = false
                    switch result {
                    case .success(let info):
                        self?.mapStationsData(statusData: info.data.stations)
                        self?.fetchLocation()
                    case .failure(let err):
                        print(err)
                    }
                }
            case .failure(let err):
                print(err)
                self?.isLoadingData.value = false
            }
        }
    }
    
    private func fetchLocation() {
        locationService.fetchLocation { [weak self] location in
            if let location = location {
                
            } else {
            }
        }
    }
    
    private func mapStationsData(statusData: [Status]) {
        stations.value = self.dataSource?.data.stations.compactMap({ station in
            let status = statusData.first(where: { $0.stationID == station.stationID })
            return StationCellViewModel(station: station, status: status)
        })
    }
    
    func numberOfRows() -> Int {
        return dataSource?.data.stations.count ?? 0
    }
}
