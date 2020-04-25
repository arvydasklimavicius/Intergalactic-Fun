

import UIKit

class PlanetCell: UITableViewCell {

    @IBOutlet weak var planetImage: UIImageView!
    @IBOutlet weak var planetTitle: UILabel!



    override func awakeFromNib() {
        super.awakeFromNib()
        planetImage.layer.cornerRadius = 10
       
    }

    func configureCell(planet: String) {
        planetTitle.text = planet.capitalized
        planetImage.image = UIImage(named: planet)
    }



}
