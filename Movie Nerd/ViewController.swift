//
//  ViewController.swift
//  Movie Nerd
//
//  Created by Kristhian De Oliveira on 9/10/19.
//  Copyright © 2019 Kristhian De Oliveira. All rights reserved.
//

import UIKit

class movieRow:UITableViewCell {
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var ArtistName: UILabel!
    @IBOutlet weak var MovieTitle: UILabel!
    
}

class ViewController: UIViewController {
    @IBOutlet weak var movieList: UITableView!
    var movies = [Result]()
    var itemsPerPage:Int = 0
    var JSONURL = "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/all/10/explicit.json"
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        //set up items per page
        let pageCount = defaults.object(forKey: "itemsPerPage") as? Float ?? 10.0//get values stored
        itemsPerPage = Int(pageCount)
        JSONURL = "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/all/\(itemsPerPage)/explicit.json"
        //END -> set up items per page
        parse()
        //Required TableView protocals
        movieList.dataSource = self
        movieList.delegate = self
        //END -> Required TableView protocals
        UIDesign()
    }
    func UIDesign() {
        let darkmodeState = defaults.object(forKey: "darkMode") as? Bool ?? true//get values stored
        if darkmodeState == true{
        view.backgroundColor = .black
        movieList.backgroundColor = .black
        }else{
            view.backgroundColor = .white
            movieList.backgroundColor = .white
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        parse()
        UIDesign()
    }
}
///TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieList.dequeueReusableCell(withIdentifier: "movieRow") as! movieRow
        //ell design
        let darkmodeState = defaults.object(forKey: "darkMode") as? Bool ?? true//get values stored
        if darkmodeState == true{
        cell.MovieTitle.textColor = .blue
        cell.ArtistName.textColor = .green
        cell.backgroundColor = .black
        }else{
            cell.MovieTitle.textColor = .black
            cell.ArtistName.textColor = .black
            cell.backgroundColor = .white
        }
        //END -> Cell design
        let row = movies[indexPath.row]//gets the array element by table row
        cell.MovieTitle.text = row.name
        cell.moviePoster.imageFromUrl(urlString: row.artworkUrl100)
        cell.ArtistName.text = row.artistName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = movies[indexPath.row]//gets the array element by table row
        let defaults = UserDefaults.standard
        defaults.setValue(row.artworkUrl100, forKeyPath: "selectedImage")
        defaults.set(row.name, forKey: "selectedName")
    }
}
//END ->TableView

