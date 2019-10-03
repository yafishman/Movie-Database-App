//
//  MovieInfoController.swift
//  YakFishman-Lab4
//
//  Created by Yak Fishman on 10/21/18.
//  Copyright © 2018 Yak Fishman. All rights reserved.
//

import Foundation
import UIKit

class MovieInfoController: UIViewController{
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var heart: UIImageView!
    @IBOutlet weak var released: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var voteCount: UILabel!
    @IBOutlet weak var notice: UILabel!
    @IBOutlet weak var credit: UIImageView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var navItem: UINavigationItem!
    var favorites : [String] = []
    var movie : Movie?
    
    @IBAction func favorites(_ sender: Any) {
        if !(hasDuplicate()) {
            favorites.append(movie!.title)
            heart.image = #imageLiteral(resourceName: "Heart")
        }
        UserDefaults.standard.set(favorites, forKey: "Favorites")
        
    }
    
    func hasDuplicate() -> Bool{
        for name in favorites {
            if(movie!.title == name) {
                return true
            }
        }
        return false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        image.image = movie?.getImage()
        released.text? = "Release Date: " + (movie?.release_date)!
        score.text? = "Score: " + String((movie?.vote_average)!) + "/10"
        voteCount.text? = "Vote Count: " + String((movie?.vote_count)!)
        navItem.title = movie?.title
        favorites = UserDefaults.standard.array(forKey: "Favorites") as! [String]
        for name in favorites {
            if(movie?.title == name) {
                heart.image = #imageLiteral(resourceName: "Heart")
            } else {
                heart.image = nil
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favorites = UserDefaults.standard.array(forKey: "Favorites") as! [String]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
