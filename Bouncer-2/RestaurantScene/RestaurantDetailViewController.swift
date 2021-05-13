//
//  RestaurantDetailViewController.swift
//  Bouncer-2
//
//  Created by Quinn Wilson on 5/12/21.
//

import UIKit
import MapKit

class RestaurantDetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceScaleLabel: UILabel!
    @IBOutlet weak var cuisineLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var attendeesLabel: UILabel!
    
    var restaurant: Restaurant!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if restaurant == nil {
            restaurant = Restaurant(location_id: "", brand_name: "", cuisine_type: "", price_scale: 0, latitude: 0.0, longitude: 0.0)
        }
        
        updateUserInterface()

    }
    
    func updateUserInterface() {
        // update nameLabel
        nameLabel.text = restaurant.brand_name
        
        // update cuisineLabel
        let cuisineText = restaurant.cuisine_type
        let cuisineTextFixed = cuisineText.replacingOccurrences(of: ";", with: ", ")
        cuisineLabel.text = cuisineTextFixed
        
        // update imageView
        
        // update priceLabel
        priceScaleLabel.text = "\(restaurant.price_scale)/5"
        
    }
    
    @IBAction func checkBoxToggled(_ sender: UIButton) {
        if sender.isSelected {
            // WORK ON THIS
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    


}
