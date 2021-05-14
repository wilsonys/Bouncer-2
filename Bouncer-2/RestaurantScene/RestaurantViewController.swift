//
//  RestaurantViewController.swift
//  Bouncer-2
//
//  Created by Quinn Wilson on 5/12/21.
//

import UIKit

class RestaurantViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var restaurants = Restaurants()
    var searchRestaurant = [Restaurant]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
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
            if searching {
                let destination = segue.destination as! RestaurantDetailViewController
                let selectedIndexPath = tableView.indexPathForSelectedRow!
                destination.restaurant = searchRestaurant[selectedIndexPath.row]
            } else {
                let destination = segue.destination as! RestaurantDetailViewController
                let selectedIndexPath = tableView.indexPathForSelectedRow!
                destination.restaurant = restaurants.restaurantArray[selectedIndexPath.row]
            }
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
        if searching {
            return searchRestaurant.count
        } else {
            return restaurants.restaurantArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantTableViewCell
        if searching {
            cell.nameLabel.text = searchRestaurant[indexPath.row].brand_name
            
            // change cuisine_type into an array to grab just the first type in the string
            let cuisineText = searchRestaurant[indexPath.row].cuisine_type
            let cuisineArray = cuisineText.components(separatedBy: ";")
            cell.friendsLabel.text = cuisineArray[0]
        } else {
            cell.nameLabel.text = restaurants.restaurantArray[indexPath.row].brand_name
            
            // change cuisine_type into an array to grab just the first type in the string
            let cuisineText = restaurants.restaurantArray[indexPath.row].cuisine_type
            let cuisineArray = cuisineText.components(separatedBy: ";")
            cell.friendsLabel.text = cuisineArray[0]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 225
    }
}

extension RestaurantViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchRestaurant = restaurants.restaurantArray.filter({$0.brand_name.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
