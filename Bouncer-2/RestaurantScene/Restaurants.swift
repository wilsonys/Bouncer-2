//
//  Restaurants.swift
//  Bouncer-2
//
//  Created by Quinn Wilson on 5/12/21.
//

import Foundation

class Restaurants {
    
    var restaurantArray: [Restaurant] = []
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
                let returned = try JSONDecoder().decode([Restaurant].self, from: data!)
                self.restaurantArray = returned
                print("*** returned json: \(returned)")
            } catch {
                print("JSON Error: \(error.localizedDescription)")
            }
            completed()
        }
        task.resume()
    }
}
