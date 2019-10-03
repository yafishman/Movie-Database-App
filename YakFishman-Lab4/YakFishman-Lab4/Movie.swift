//
//  Movie.swift
//  YakFishman-Lab4
//
//  Created by Yak Fishman on 10/20/18.
//  Copyright © 2018 Yak Fishman. All rights reserved.
//

import Foundation
import UIKit

struct Movie: Decodable {
    let id: Int!
    let poster_path: String?
    let adult: Bool
    let original_language : String
    let title: String
    let release_date: String
    let vote_average: Double
    let overview: String
    let vote_count:Int!
    
    func getImage() -> UIImage{
        if(poster_path == nil) {
            return #imageLiteral(resourceName: "no_photo")
        } else {
        var moviePath = "https://image.tmdb.org/t/p/w500"
        //This product uses the TMDb API but is not endorsed or certified by TMDb.
        moviePath.append(poster_path!)
        let imageURL = URL(string: moviePath)
        let imageData = try! Data(contentsOf: imageURL!)
        let image = UIImage(data: imageData)
        return image!
        }
    }
}
