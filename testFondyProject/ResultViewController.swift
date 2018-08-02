//
//  ResultViewController.swift
//  testFondyProject
//
//  Created by Julia Nikitina on 02/08/2018.
//  Copyright © 2018 Julia Nikitina. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    var result: String?
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultLabel.text = result
    }
}
