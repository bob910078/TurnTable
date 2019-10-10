//
//  ViewController.swift
//  TurnTable
//
//  Created by Bob Chang on 2019/10/10.
//  Copyright © 2019 Dandelion. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let turnView = UIView()
    @IBOutlet weak var myLabel: UILabel!
    
    var sum: Float = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        turnView.backgroundColor = UIColor.systemBlue
        turnView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(turnView)
        
        turnView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        turnView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        turnView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        turnView.heightAnchor.constraint(equalTo: turnView.widthAnchor).isActive = true
        
        let panG = UIPanGestureRecognizer(target: self, action: #selector(pan(gesture:)))
        turnView.addGestureRecognizer(panG)
        
        myLabel.text = self.sum.desc
    }
    
    
    lazy var movement: TurnTableMovementTracker = {
        let rectSize = self.turnView.bounds.size
        let fulcrum = CGPoint(x: rectSize.width / 2, y: rectSize.height / 2)
        let helper = TurnTableMovementTracker(fulcrumPoint: fulcrum)
        helper.updateValue = { [weak self] movement in
            self?.sum += movement.value.rounded(FloatingPointRoundingRule.toNearestOrAwayFromZero)
            self?.myLabel.text = self?.sum.desc
        }
        return helper
    }()
    
    @objc func pan(gesture: UIGestureRecognizer) {
        
        let location = gesture.location(in: self.turnView)
        // print(location)
        movement.touchPoint.value = location
    }
    
}


extension Float {
    var desc: String {
        return String(self)
    }
}
