//
//  BouncerUsers.swift
//  Bouncer-2
//
//  Created by Quinn Wilson on 5/14/21.
//

import Foundation
import Firebase

class BouncerUsers {
    var userArray: [BouncerUser] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ()) {
        db.collection("users").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.userArray = [] // clean out the existing userArray since new data will load
            // there are querySnapshot!.documents.count documents in the snapshot
            for document in querySnapshot!.documents {
                // you will have to make sure you have a dictionary initializer in the singular class
                let bouncerUser = BouncerUser(dictionary: document.data())
                bouncerUser.documentID = document.documentID
                self.userArray.append(bouncerUser)
            }
            completed()
        }
    }
}
