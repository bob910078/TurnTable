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
    
    // fulcrum 中譯為支點，此處指的是極坐標的原點
    var fulcrum: CGPoint {
        return CGPoint(x: bounds.width / 2, y: bounds.height / 2)
    }
    
    private lazy var polarSystem = PolarCoordination(origin: fulcrum)
    
    var touchPoint: Observable<CGPoint> = Observable<CGPoint>.init(.zero)

    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGe = UITapGestureRecognizer(target: self, action: #selector(tap(gesture:)))
        self.addGestureRecognizer(tapGe)
        
        self.touchPoint.listener = { [weak self] (oldCartesia, newCartesia) in
            
            let deltaX = newCartesia.x-oldCartesia.x
            let deltaY = newCartesia.y-oldCartesia.y
            // print("old \(old), new \(new) --- delX \(deltaX), delY \(deltaY)")
            
            guard deltaX != 0 || deltaY != 0 else { return }
            guard let self = self else { return }
            let oldPolar = self.polarSystem.convert(from: oldCartesia)
            let newPolar = self.polarSystem.convert(from: newCartesia)
            // print("old \(oldPolar), new \(newPolar)")
            
            // φ in the interval (−π, π]
            let deltaAngle = newPolar.angle - oldPolar.angle
            
            let clockwise: TurnMovement.TurnDirenction = (deltaAngle < 0) ? .cw : .ccw
            let output: Float = {
                let ret = Float(deltaAngle * 100)
                let validRange = -50.0...50.0
                let isValid = validRange.contains(Double(ret))
                return isValid ? ret : 0.0
            }()
            let movement = TurnMovement(direction: clockwise, value: output)
            let newValue = movement.value.rounded(.toNearestOrAwayFromZero)
            self.updateValue?(newValue)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self) {
            self.touchPoint.value = location
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
