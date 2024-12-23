//
//  ViewController.swift
//  ChristmasOxSpirit
//
//  Created by jin fu on 2024/12/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    
    var name = "Christmas Ox Spirit"
    var index = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = ""
        for n in name{
            Timer.scheduledTimer(withTimeInterval: 0.1 * index, repeats: false) { timer in
                self.nameLbl.text?.append(n)
            }
            index += 1
        }
        
    }

    @IBAction func startBtn(_ sender: UIButton) {
    }
}

