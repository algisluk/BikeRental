import UIKit

class BikeStationsViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    private let bikeStationCellReuseIdentifier = "BikeStationTableViewCell"
    
    var viewModel: StationsViewModel = StationsViewModel()
    var stationsDataSource: [StationCellViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: bikeStationCellReuseIdentifier, bundle: nil), forCellReuseIdentifier: bikeStationCellReuseIdentifier)
        bindViewModel()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.fetchData()
    }
    
    func bindViewModel() {
        viewModel.isLoadingData.bind { [weak self] isLoading in
            guard let isLoading = isLoading else {
                return
            }
            DispatchQueue.main.async {
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
        
        viewModel.stations.bind { [weak self] stations in
            guard let self = self, let stations = stations else {
                return
            }
            self.stationsDataSource = stations
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension BikeStationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: bikeStationCellReuseIdentifier, for: indexPath) as! BikeStationTableViewCell
        cell.configure(viewModel: stationsDataSource[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let station = stationsDataSource[indexPath.row]
        guard let status = viewModel.dataSource?.data.stations.first(where: {$0.stationID == station.id}) else { return }
        let stationDetailsViewModel = StationDetailsViewModel(station: station, lat: status.lat, lon: status.lon)
        let stationDetailsViewController = UIStoryboard(name: "StationDetailsViewController", bundle: nil).instantiateViewController(withIdentifier: "StationDetailsViewController") as! StationDetailsViewController
        stationDetailsViewController.viewModel = stationDetailsViewModel
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(stationDetailsViewController, animated: true)
        }
    }
}
