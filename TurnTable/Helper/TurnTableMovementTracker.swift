//
//  TurnTableMovementTracker.swift
//  TurnTable
//
//  Created by Bob Chang on 2019/10/10.
//  Copyright © 2019 Dandelion. All rights reserved.
//

import UIKit

class TurnTableMovementTracker {
    
    private let fulcrumPoint: CGPoint
    private let polarSystem: PolarCoordination
    
    var touchPoint: Observable<CGPoint>
    var updateValue: ((TurnMovement) -> Void)?
    
    init(fulcrumPoint: CGPoint) {
        self.fulcrumPoint = fulcrumPoint
        self.polarSystem = PolarCoordination(origin: fulcrumPoint)
        
        self.touchPoint = Observable.init(CGPoint.zero)
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
            self.updateValue?(movement)
        }
    }
    
}

struct TurnMovement {
    
    let direction: TurnDirenction
    let value: Float
    
    /// https://en.wikipedia.org/wiki/Clockwise
    /// - clockwise 順時針方向
    /// - counterclockwise 逆時針方向
    enum TurnDirenction {
        case cw, ccw
    }
}
