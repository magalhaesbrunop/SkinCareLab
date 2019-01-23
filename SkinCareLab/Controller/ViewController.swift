//
//  ViewController.swift
//  SkinCareLab
//
//  Created by Bruno Magalhães on 16/01/19.
//  Copyright © 2019 Cybernetic Company of Milky Way. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var analizeButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImage.layer.cornerRadius = 20
        analizeButton.layer.cornerRadius = 10
        analizeButton.layer.borderWidth = 3
        analizeButton.layer.borderColor = UIColor.black.cgColor
        
    }

    @IBAction func analizeButton(_ sender: Any) {
        
        
    }
    
}

