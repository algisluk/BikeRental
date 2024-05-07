import Foundation

public enum APIError: Error {
    case decodeError
}

class APIService {
    private let stationsURL = URL(string: "https://gbfs.urbansharing.com/rowermevo.pl/station_information.json")!
    private let stationsDetailsURL = URL(string: "https://gbfs.urbansharing.com/rowermevo.pl/station_status.json")!
    
    func apiToGetStationsData(completion: @escaping (_ result: Result<StationInfo, APIError>) -> ()){
        URLSession.shared.dataTask(with: stationsURL) { (data, urlResponse, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let data = try! jsonDecoder.decode(StationInfo.self, from: data)
                completion(.success(data))
            } else {
                print(error.debugDescription)
                completion(.failure(.decodeError))
            }
            
        }.resume()
    }
    
    func apiToGetStationsDetailsData(completion : @escaping (_ result: Result<StationStatus, APIError>) -> ()){
        URLSession.shared.dataTask(with: stationsDetailsURL) { (data, urlResponse, error) in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let data = try! jsonDecoder.decode(StationStatus.self, from: data)
                completion(.success(data))
            } else {
                print(error.debugDescription)
                completion(.failure(.decodeError))
            }
            
        }.resume()
    }
}
