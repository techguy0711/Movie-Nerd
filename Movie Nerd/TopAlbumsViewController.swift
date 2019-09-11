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
    var JSONURL = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/10/explicit.json"
    var music = [Result]()
    var itemsPerPage:Int = 0
    let defaults = UserDefaults.standard
    @IBOutlet weak var albumList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //set up items per page
        let pageCount = defaults.object(forKey: "itemsPerPage") as? Float ?? 10.0//get values stored
        itemsPerPage = Int(pageCount)
        JSONURL = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/\(itemsPerPage)/explicit.json"
        //END -> set up items per page
        //Required TableView protocals
        albumList.delegate = self
        albumList.dataSource = self
        //END -> Required TableView protocals
        parse()//Network request to fetch data
        UIDesign()
    }
    func UIDesign() {
        let darkmodeState = defaults.object(forKey: "darkMode") as? Bool ?? true//get values stored
        if darkmodeState == true {
        view.backgroundColor = .black
        albumList.backgroundColor = .black
        albumList.backgroundColor = .black
        }else{
            view.backgroundColor = .white
            albumList.backgroundColor = .white
            albumList.backgroundColor = .white
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        parse()
        UIDesign()
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
        let darkmodeState = defaults.object(forKey: "darkMode") as? Bool ?? true//get values stored
        if darkmodeState == true{
        cell.albumName.textColor = .blue
        cell.artistName.textColor = .green
        cell.backgroundColor = .black
        }else{
            cell.albumName.textColor = .black
            cell.artistName.textColor = .black
            cell.backgroundColor = .white
        }
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
