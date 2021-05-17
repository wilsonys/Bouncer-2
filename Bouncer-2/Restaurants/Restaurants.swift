//
//  Restaurants.swift
//  Bouncer-2
//
//  Created by Quinn Wilson on 5/12/21.
//

import Foundation
import Firebase

class Restaurants {
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    var restaurantArray: [Restaurant] = []
    var countArray: [RestaurantCount] = []
    var urlString = "https://raw.githubusercontent.com/rogerwangcs/boston-food-vis/master/restaurants.json"
    
    func getData(completed: @escaping()->()) {
        print("We are accessing \(urlString)")
        
        // create a url
        guard let url = URL(string: urlString) else {
            print("Could not create url from \(urlString)")
            completed()
            return
        }
        
        // create a session
        let session = URLSession.shared
        
        // create a task using the dataTask method
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            
            // deal with data
            do {
                var returned = try JSONDecoder().decode([Restaurant].self, from: data!)
                returned.sort(by: {$0.brand_name < $1.brand_name})
                self.restaurantArray = returned
            } catch {
                print("JSON Error: \(error.localizedDescription)")
            }
            completed()
        }
        task.resume()
    }
    
}
