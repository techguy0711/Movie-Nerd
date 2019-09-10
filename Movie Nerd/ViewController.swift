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
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var MovieTitle: UILabel!
    
}

class ViewController: UIViewController {
    @IBOutlet weak var movieList: UITableView!
    var movies = [Result]()
    let JSONURL = "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/all/10/explicit.json"
    override func viewDidLoad() {
        super.viewDidLoad()
        //Required TableView protocals
        movieList.dataSource = self
        movieList.delegate = self
        //END -> Required TableView protocals
        parse()
    }
    func parse() -> Void {
        guard let gitUrl = URL(string: JSONURL) else { return }
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let content = try decoder.decode(Empty.self, from: data)
                self.movies = content.feed.results
                DispatchQueue.main.async {
                    self.movieList.reloadData()
                    
                }
            } catch let err {
                print("Err", err)
            }
            }.resume()
    }
}
///TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(movies.count)
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieList.dequeueReusableCell(withIdentifier: "movieRow") as! movieRow
        let row = movies[indexPath.row]//gets the array element by table row
        cell.MovieTitle.text = row.name
        cell.moviePoster.imageFromUrl(urlString: row.artworkUrl100)
        cell.releaseDate.text = row.artistName
        //Asign data to tableview
        cell.MovieTitle.text = "Test"
        return cell
    }


}
//END ->TableView

