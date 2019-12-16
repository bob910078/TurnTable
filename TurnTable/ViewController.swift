//
//  ViewController.swift
//  TurnTable
//
//  Created by Bob Chang on 2019/10/10.
//  Copyright © 2019 Dandelion. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var costDisplayLabel: UILabel!
    @IBOutlet weak var turnView: TurnTableView!
    
    var sum: Float = 100 {
        didSet {
            self.updateValueLabel(newValue: self.sum)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.updateValueLabel(newValue: self.sum)
        
        self.turnView.updateValue = { [unowned self] newValue in
            self.sum += newValue
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let border = max(turnView.bounds.size.width / 2, turnView.bounds.size.height / 2)
        turnView.layer.cornerRadius = border
    }
    
    func updateValueLabel(newValue: Float) {
        DispatchQueue.main.async {
            self.costDisplayLabel.text = String(newValue)
        }
    }
}
