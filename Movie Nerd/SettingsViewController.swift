//
//  SettingsViewController.swift
//  Movie Nerd
//
//  Created by Kristhian De Oliveira on 9/11/19.
//  Copyright © 2019 Kristhian De Oliveira. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var darkmodeLabel: UILabel!
    @IBOutlet weak var isDarkModeEnabled: UISwitch!
    @IBOutlet weak var numberOfItemsPerPage: UISlider!
    @IBOutlet weak var itemsPerPageLabel: UILabel!
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        //set value constraints
        numberOfItemsPerPage.minimumValue = 10.0
        numberOfItemsPerPage.maximumValue = 100.0
        //END -> set value constraints
        super.viewDidLoad()
        let darkmodeState = defaults.object(forKey: "darkMode") as? Bool ?? true//get values stored
        let pageCount = defaults.object(forKey: "itemsPerPage") as? Float ?? 10.0//get values stored
        isDarkModeEnabled.setOn(darkmodeState, animated: true)
        numberOfItemsPerPage.setValue(pageCount, animated: true)
        itemsPerPageLabel.text = "\(Int(pageCount)) items per page"
    }
    @IBAction func darkModeValueChanged(_ sender: Any) {
        defaults.set(isDarkModeEnabled.isOn, forKey: "darkMode")
        if isDarkModeEnabled.isOn {
            view.backgroundColor = .black
            darkmodeLabel.textColor = .white
            itemsPerPageLabel.textColor = .white
        }
    }
    @IBAction func pageCountChanged(_ sender: Any) {
        defaults.set(numberOfItemsPerPage.value.rounded(), forKey: "itemsPerPage")
        itemsPerPageLabel.text = "\(Int(numberOfItemsPerPage.value)) items per page"
    }
    
}
