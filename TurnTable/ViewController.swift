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
    @IBOutlet weak var turnView: UIView!
    
    var sum: Float = 100 {
        didSet {
            DispatchQueue.main.async {
                self.costDisplayLabel.text = self.sum.desc
            }
        }
    }
    
    lazy var movement: TurnTableMovementTracker = {
        let rectSize = self.turnView.bounds.size
        let fulcrum = CGPoint(x: rectSize.width / 2, y: rectSize.height / 2)
        let helper = TurnTableMovementTracker(fulcrumPoint: fulcrum)
        helper.updateValue = { [weak self] movement in
            guard let self = self else { return }
            let newValue = movement.value.rounded(.toNearestOrAwayFromZero)
            guard self.sum + newValue >= 0 else { return }
            self.sum += newValue
        }
        return helper
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let panG = UIPanGestureRecognizer(target: self, action: #selector(pan(gesture:)))
        turnView.addGestureRecognizer(panG)
        
        let tapG = UITapGestureRecognizer(target: self, action: #selector(tap(gesture:)))
        turnView.addGestureRecognizer(tapG)
        
        costDisplayLabel.text = self.sum.desc
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let border = max(turnView.bounds.size.width / 2, turnView.bounds.size.height / 2)
        turnView.layer.cornerRadius = border
    }
    
    @objc func pan(gesture: UIGestureRecognizer) {
        let location = gesture.location(in: self.turnView)
        // print(location)
        movement.touchPoint.value = location
    }
    
    @objc func tap(gesture: UIGestureRecognizer) {
        let location = gesture.location(in: self.turnView)
        let isIncreasementArea = location.x > turnView.bounds.width / 2
        sum += isIncreasementArea ? 1 : -1
    }
    
}


extension Float {
    var desc: String { String(Int(self)) }
}
