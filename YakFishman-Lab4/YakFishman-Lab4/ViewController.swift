//
//  ViewController.swift
//  YakFishman-Lab4
//
//  Created by Yak Fishman on 10/19/18.
//  Copyright © 2018 Yak Fishman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchControllerDelegate, UISearchBarDelegate {
    var movies : [Movie] = []
    var favoritez : [String] = []
    var index : IndexPath = []
    var englishMode = false
    @IBOutlet weak var wheel: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var langLabel: UIButton!
    
    @IBAction func langButton(_ sender: Any) {
        if englishMode {
            englishMode = false
            langLabel.setTitle("Change to English Only", for: .normal)
            searchBarSearchButtonClicked(searchBar)
        } else {
            englishMode = true
            langLabel.setTitle("Change to All Languages", for: .normal)
            searchBarSearchButtonClicked(searchBar)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        wheel.startAnimating()
        movies.removeAll()
        if (searchBar.text == "") {
            searchBar.text = " "
        }
        guard let stringArray = searchBar.text?.components(separatedBy: " ")
            else {
                return;
            }
        var urlString = "https://api.themoviedb.org/3/search/movie?api_key=e488efcc1562268ccba6de7a79bb1bf4&query="
        //This product uses the TMDb API but is not endorsed or certified by TMDb.
        var i = 0
        while(i < (stringArray.count)-1){
            urlString.append(stringArray[i])
            urlString.append("+")
            i += 1
        }
        urlString.append(stringArray[i])
        getJSONData(string: urlString)
        
    }
    
    func getJSONData(string: String){
        DispatchQueue.global().async {
            let url = URL(string: string)
            let data = try! Data(contentsOf: url!)
            let json = try! JSONDecoder().decode(APIResults.self, from: data)
            self.movies = json.results
            var i = 0
            while i < self.movies.count{
                if (self.movies[i].original_language != "en") && self.englishMode {
                    self.movies.remove(at: i)
                }
                i += 1
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.wheel.stopAnimating()
            }
            self.wheel.hidesWhenStopped = true
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource=self
        wheel.hidesWhenStopped = true
        searchBar.delegate = self
        collectionView.delegate=self
        if(UserDefaults.standard.array(forKey: "Favorites") == nil) {
            UserDefaults.standard.set(favoritez, forKey: "Favorites")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        index = indexPath
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: index) as! CollectionViewCell
        cell.setCell(movie: movies[index.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index = indexPath
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        self.performSegue(withIdentifier: "movieSegue", sender: cell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieSegue" {
            let newViewController = segue.destination as? MovieInfoController
            newViewController?.movie = movies[index.row]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    struct APIResults:Decodable {
        let page: Int
        let total_results: Int
        let total_pages: Int
        let results: [Movie]
    }
}

