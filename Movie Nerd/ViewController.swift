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
        parse()
        //Required TableView protocals
        movieList.dataSource = self
        movieList.delegate = self
        //END -> Required TableView protocals
        UIDesign()
    }
    func UIDesign() {
        view.backgroundColor = .black
        movieList.backgroundColor = .black
    }
    //Requests JSON data from the network
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        parse()
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
        cell.MovieTitle.textColor = .blue
        cell.releaseDate.textColor = .green
        cell.backgroundColor = .black
        //END -> Cell design
        let row = movies[indexPath.row]//gets the array element by table row
        cell.MovieTitle.text = row.name
        cell.moviePoster.imageFromUrl(urlString: row.artworkUrl100)
        cell.releaseDate.text = row.artistName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var toggle = false
        let row = movies[indexPath.row]//gets the array element by table row
        let preview = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/2))
        preview.imageFromUrl(urlString: row.artworkUrl100)
        view.addSubview(preview)
        movieList.isHidden = true
    }
    
}
//END ->TableView

