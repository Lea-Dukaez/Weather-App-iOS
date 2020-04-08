//
//  ViewController.swift
//  ClimaApp
//
//  Created by Léa on 07/04/2020.
//  Copyright © 2020 Lea Dukaez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    var city = ""

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // the TextField should report back to the viewController
        searchTextField.delegate = self
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(city)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        print(city)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Please enter a city"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // use searchTextField.text to get the weather for that city
        city = searchTextField.text!
        searchTextField.text = ""
    }
}

