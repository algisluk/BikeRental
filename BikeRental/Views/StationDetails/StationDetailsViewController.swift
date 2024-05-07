import UIKit
import MapKit

class StationDetailsViewController: UIViewController {

    var viewModel: StationDetailsViewModel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var bikesCountLabel: UILabel!
    @IBOutlet weak var placesCountLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = viewModel.name
        distanceLabel.text = "- • "
        addressLabel.text = viewModel.address
        bikesCountLabel.text = viewModel.numBikesAvailable
        placesCountLabel.text = viewModel.numDocksAvailable
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: viewModel.lat, longitude: viewModel.lon)
        mapView.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        
    }
    
}

extension StationDetailsViewController: MKMapViewDelegate {
}
