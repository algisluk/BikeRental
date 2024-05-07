import UIKit

class BikeStationTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = 16
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var placeCountLabel: UILabel!
    @IBOutlet weak var bikeCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(viewModel: StationCellViewModel) {
        self.titleLabel.text = viewModel.name
        self.distanceLabel.text = "- • "
        self.addressLabel.text = viewModel.address
        self.placeCountLabel.text = viewModel.numDocksAvailable
        self.bikeCountLabel.text = viewModel.numBikesAvailable
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = "-"
        self.addressLabel.text = "-"
        self.placeCountLabel.text = "-"
        self.bikeCountLabel.text = "-"
    }
}
