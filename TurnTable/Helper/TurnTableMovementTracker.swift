//
//  TurnTableMovementTracker.swift
//  TurnTable
//
//  Created by Bob Chang on 2019/10/10.
//  Copyright © 2019 Dandelion. All rights reserved.
//

import UIKit

class TurnTableMovementTracker {
    
    let fulcrumPoint: CGPoint
    let polarSystem: PolarCoordination
    
    var touchPoint: Observable<CGPoint>
    
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
            
            let deltaAngle = newPolar.angle - oldPolar.angle
            let clockwise = (deltaAngle < 0) ? "clockwise" : "counter-clockwise"
            print(clockwise)
        }
    }
    
}

