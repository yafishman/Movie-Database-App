//
//  FavoritesViewController.swift
//  YakFishman-Lab4
//
//  Created by Yak Fishman on 10/21/18.
//  Copyright © 2018 Yak Fishman. All rights reserved.
//

import Foundation
import UIKit
class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var favorite : [String] = []
    var index : IndexPath = []
    var sorted = false
    var tempArray : [String] = []
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortLabel: UILabel!
    @IBOutlet weak var alpabetLabel: UIButton!
    

    

    @IBAction func alphabetButton(_ sender: Any) {
        if(sorted) {
            favorite = tempArray
            sorted = false
            alpabetLabel.setTitle("Sort Alphabetically", for: .normal)
        } else {
            sort()
            sorted = true
            alpabetLabel.setTitle("Sort by Recently Added", for: .normal)
        }
        tableView.reloadData()
    }
    func sort() {
        favorite = UserDefaults.standard.array(forKey: "Favorites") as! [String]
        var sortedArray : [String]
        tempArray = favorite
        sortedArray = favorite.sorted()
        favorite = sortedArray
    }
    
    @IBAction func clear(_ sender: Any) {
        favorite.removeAll()
        tempArray.removeAll()
        UserDefaults.standard.set(favorite, forKey: "Favorites")
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorite.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "tableViewCell")
        index = indexPath
        cell.textLabel!.text = favorite[index.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        index = indexPath
        if (editingStyle == .delete) {
            favorite.remove(at: index.row)
            UserDefaults.standard.set(favorite, forKey: "Favorites")
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favorite = UserDefaults.standard.array(forKey: "Favorites") as! [String]
        tempArray = UserDefaults.standard.array(forKey: "Favorites") as! [String]
        print(favorite)
        tableView.dataSource=self
        tableView.delegate=self
    }
    override func viewWillAppear(_ animated: Bool) {
        favorite = UserDefaults.standard.array(forKey: "Favorites") as! [String]
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
