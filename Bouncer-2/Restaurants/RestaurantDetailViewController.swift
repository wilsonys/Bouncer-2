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
    @IBOutlet weak var attendeesLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var attendeeSwitch: UISwitch!
    
    var restaurant: Restaurant!
    var restaurantCount: RestaurantCount!
    
    let regionDistance: CLLocationDegrees = 750.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attendeeSwitch.isOn = false
        
        if restaurant == nil {
            restaurant = Restaurant(location_id: "", brand_name: "", cuisine_type: "", price_scale: 0, latitude: 0.0, longitude: 0.0)
        }
        
        if restaurantCount == nil {
            restaurantCount = RestaurantCount(restaurant: restaurant, currentUserAttending: false, attendeeCount: 0)
        }
        
        updateUserInterface()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if attendeeSwitch.isOn {
            attendeeSwitch.isOn = true
        } else {
            attendeeSwitch.isOn = false
        }
    }
    
    func setUpMapView() {
        var coordinate = CLLocationCoordinate2D()
        coordinate.latitude = restaurant.latitude
        coordinate.longitude = restaurant.longitude
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = restaurant.brand_name
        mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        mapView.setRegion(region, animated: true)
    }
    
    func updateUserInterface() {
        // update nameLabel
        nameLabel.text = restaurant.brand_name
        
        // update cuisineLabel
        let cuisineText = restaurant.cuisine_type
        let cuisineTextFixed = cuisineText.replacingOccurrences(of: ";", with: ", ")
        cuisineLabel.text = cuisineTextFixed
        
        // update imageView
        let cuisineArray = cuisineText.components(separatedBy: ";")
        imageView.image = UIImage(named: cuisineArray[0])
        
        // update priceLabel
        priceScaleLabel.text = "\(restaurant.price_scale)/5"
        
        // update attendeesLabel
        attendeesLabel.text = "\(restaurantCount.attendeeCount)"
        
        setUpMapView()
    }
    
    @IBAction func attendeeSwitchToggled(_ sender: UISwitch) {
        if attendeeSwitch.isOn {
            print("current user is attending")
            restaurantCount.attendeeCount += 1
            print("Total attending: \(restaurantCount.attendeeCount)")
            attendeesLabel.text = "\(restaurantCount.attendeeCount)"
            updateUserInterface()
        } else {
            print("current user is not attending")
            restaurantCount.attendeeCount -= 1
            print("Total attending: \(restaurantCount.attendeeCount)")
            updateUserInterface()
        }
    }
}
