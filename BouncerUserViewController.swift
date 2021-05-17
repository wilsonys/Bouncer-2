//
//  BouncerUserViewController.swift
//  Bouncer-2
//
//  Created by Quinn Wilson on 5/14/21.
//

import UIKit
import SDWebImage

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    return dateFormatter
}()

class BouncerUserViewController: UIViewController {
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userSinceLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var bouncerUsers: BouncerUsers!
    
    var bouncerUser: BouncerUser! {
        didSet {
            displayNameLabel.text = bouncerUser.displayName
            userSinceLabel.text = "\(dateFormatter.string(from: bouncerUser.userSince))"
            emailLabel.text = bouncerUser.email
            
            // round corners on the imageView
            imageView.layer.cornerRadius = self.imageView.frame.size.width / 2
            imageView.clipsToBounds = true
            
            guard let url = URL(string: bouncerUser.photoURL) else {
                print("No valid URL")
                imageView.image = UIImage(systemName: "person.crop.circle")
                return
            }
            imageView.sd_imageTransition = .fade
            imageView.sd_imageTransition?.duration = 0.1
            imageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "person.crop.circle"))
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayNameLabel.text = bouncerUser.displayName
        userSinceLabel.text = "\(dateFormatter.string(from: bouncerUser.userSince))"
        emailLabel.text = bouncerUser.email
        
        guard let url = URL(string: bouncerUser.photoURL) else {
            imageView.image = UIImage(systemName: "person.crop.cirlce")
            return
        }
        imageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "person.crop.cirlce"))
        
        //        bouncerUsers = BouncerUsers()
        //        bouncerUsers.loadData {
        //            print("loading data!")
        //        }
        
    }
}

