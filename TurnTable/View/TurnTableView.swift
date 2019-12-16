//
//  TurnTableView.swift
//  TurnTable
//
//  Created by Bob Chang on 2019/12/16.
//  Copyright © 2019 Dandelion. All rights reserved.
//

import UIKit

class TurnTableView: UIView {
    
    var updateValue: ((Float) -> Void)?
    
    lazy var movement: TurnTableMovementTracker = {
        // fulcrum 中譯為支點，此處指的是極坐標的原點
        let fulcrum = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let helper = TurnTableMovementTracker(fulcrumPoint: fulcrum)
        helper.updateValue = { movement in
            let newValue = movement.value.rounded(.toNearestOrAwayFromZero)
            self.updateValue?(newValue)
        }
        return helper
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGe = UITapGestureRecognizer(target: self, action: #selector(tap(gesture:)))
        self.addGestureRecognizer(tapGe)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self) {
            movement.touchPoint.value = location
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }

    @objc
    private func tap(gesture: UIGestureRecognizer) {
        let location = gesture.location(in: self)
        let isIncreasementArea = location.x > self.bounds.width / 2
        let newValue: Float = isIncreasementArea ? 1 : -1
        self.updateValue?(newValue)
    }

}
