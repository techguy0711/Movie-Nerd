//
//  detailViewController.swift
//  Movie Nerd
//
//  Created by Kristhian De Oliveira on 9/11/19.
//  Copyright © 2019 Kristhian De Oliveira. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {
    @IBOutlet weak var poster_Image: UIImageView!
    @IBOutlet weak var Movie_title: UILabel!
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        let imageURL = defaults.object(forKey: "selectedImage") as! String
        poster_Image.imageFromUrl(urlString: imageURL)
        let name = defaults.object(forKey: "selectedName") as! String
        Movie_title.text = name
    }
    
}
