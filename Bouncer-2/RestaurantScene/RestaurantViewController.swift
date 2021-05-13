//
//  RestaurantViewController.swift
//  Bouncer-2
//
//  Created by Quinn Wilson on 5/12/21.
//

import UIKit

class RestaurantViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var restaurants = Restaurants()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        restaurants.getData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            print("Getting json data!")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRestaurant" {
            let destination = segue.destination as! RestaurantDetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.restaurant = restaurants.restaurantArray[selectedIndexPath.row]
        }
    }
    
//    @IBAction func unwindFromRestaurantDetail(segue: UIStoryboardSegue) {
//        let source = segue.source as! RestaurantDetailViewController
//        if let selectedIndexPath = tableView.indexPathForSelectedRow {
//            restaurants.restaurantArray[selectedIndexPath.row] = source.restaurant
//            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
//        }
//    }


}

extension RestaurantViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurants.restaurantArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantTableViewCell
        cell.nameLabel.text = restaurants.restaurantArray[indexPath.row].brand_name
        
        // change cuisine_type into an array to grab just the first type in the string
        let cuisineText = restaurants.restaurantArray[indexPath.row].cuisine_type
        let cuisineArray = cuisineText.components(separatedBy: ";")
        cell.friendsLabel.text = cuisineArray[0]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 225
    }
}

