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
    var imageURL = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        poster_Image.imageFromUrl(urlString: imageURL)
    }
    
}
