//
//  Networking.swift
//  Movie Nerd
//
//  Created by Kristhian De Oliveira on 9/10/19.
//  Copyright © 2019 Kristhian De Oliveira. All rights reserved.
//

import Foundation

//struct Welcome: Codable {
//    let content : content
//}

struct Result:Codable {
    var artistName:String
    var name:String
    var artworkUrl100:String
    enum codingKeys:String, CodingKey {
        case artistName = "artistName"
        case name = "name"
        case artworkUrl100 = "artworkUrl100"
    }
}
struct feed:Codable {
    var results:[Result]
    enum codingKeys:String, CodingKey {
        case results = "results"
    }
}
struct Empty:Codable {
    var feed:feed
    enum codingKeys:String, CodingKey {
        case feed = "feed"
    }
}
extension ViewController {
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
}
