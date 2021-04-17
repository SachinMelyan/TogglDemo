//
//  ViewController.swift
//  SwitchExample
//
//  Created by Sachin Kumar on 24/10/20.
//  Copyright © 2020 Sachin Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Interface Builder Outlets
    @IBOutlet private weak var toggle: Toggle!

    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    // MARK: - Interface Builder Actions
    @IBAction func toggleValueChanged(_ toggle: Toggle) {
        if toggle.isOn {
            print("Toggle is on")
        }
        else {
            print("Toggle in off")
        }
    }

}

