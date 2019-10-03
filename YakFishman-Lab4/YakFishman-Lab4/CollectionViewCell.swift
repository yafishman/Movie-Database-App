//
//  CollectionViewCell.swift
//  YakFishman-Lab4
//
//  Created by Yak Fishman on 10/20/18.
//  Copyright © 2018 Yak Fishman. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var heartImage: UIImageView!
    
    func setCell(movie: Movie) {
        cellImage.image = movie.getImage()
        cellLabel.text = movie.title
        heartImage.image = nil
        let favorites = UserDefaults.standard.array(forKey: "Favorites") as! [String]
        for name in favorites {
            if(movie.title == name) {
                heartImage.image = #imageLiteral(resourceName: "Heart")
            } else {
            }
        }
    }
}
