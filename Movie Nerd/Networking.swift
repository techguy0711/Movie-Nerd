//
//  Networking.swift
//  Movie Nerd
//
//  Created by Kristhian De Oliveira on 9/10/19.
//  Copyright © 2019 Kristhian De Oliveira. All rights reserved.
//

import Foundation

struct feed:Codable {
    var title:String
    var releaseDate:String
    var artworkUrl100:String
}
struct Movies:Codable {
    var results:[feed]
}

class requests {
    var movies = [feed]()
    func getCommingSoon() -> Void {
        let JSONURL = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/10/non-explicit.json"
        if let url = URL(string: JSONURL) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }

    }
    private func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let JSONalbums = try? decoder.decode(Movies.self, from: json) {
            movies = JSONalbums.results
        }
    }
}
