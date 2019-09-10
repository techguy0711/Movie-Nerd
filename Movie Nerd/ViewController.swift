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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
///TableView
//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//    
//    
//}  
//END ->TableView

