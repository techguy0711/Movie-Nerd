//
//  TopAlbumsViewController.swift
//  Movie Nerd
//
//  Created by Kristhian De Oliveira on 9/11/19.
//  Copyright © 2019 Kristhian De Oliveira. All rights reserved.
//

import UIKit

class albumRow:UITableViewCell {
    @IBOutlet weak var albumCover: UIImageView!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var artistName: UILabel!
}

class TopAlbumsViewController: UIViewController {
    let JSONURL = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/10/explicit.json"
    var music = [Result]()
    @IBOutlet weak var albumList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Required TableView protocals
        albumList.delegate = self
        albumList.dataSource = self
        //END -> Required TableView protocals
        parse()//Network request to fetch data
        UIDesign()
    }
    func UIDesign() {
        view.backgroundColor = .black
        albumList.backgroundColor = .black
    }
}
///TableView
extension TopAlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return music.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = albumList.dequeueReusableCell(withIdentifier: "albumRow") as! albumRow
        //ell design
        cell.albumName.textColor = .blue
        cell.artistName.textColor = .green
        cell.backgroundColor = .black
        //END -> Cell design

        let album = music[indexPath.row]
        cell.albumCover.imageFromUrl(urlString: album.artworkUrl100)
        cell.albumName.text = album.name
        cell.artistName.text = album.artistName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = music[indexPath.row]//gets the array element by table row
        let defaults = UserDefaults.standard
        defaults.setValue(row.artworkUrl100, forKeyPath: "selectedImage")
        defaults.set(row.name, forKey: "selectedName")
    }
    
}
///END -> TableView
