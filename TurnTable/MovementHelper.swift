//
//  MovementHelper.swift
//  TurnTable
//
//  Created by Bob Chang on 2019/10/10.
//  Copyright © 2019 Dandelion. All rights reserved.
//

import UIKit

class MovementHelper {
    
    let fulcrumPoint: CGPoint
    var touchPoint: Observable<CGPoint>
    
    lazy var polarSystem = PolarCoordination(origin: fulcrumPoint)
    
    init(fulcrumPoint: CGPoint) {
        self.fulcrumPoint = fulcrumPoint
        self.touchPoint = Observable.init(CGPoint.zero)
        self.touchPoint.listener = { [weak self] (old, new) in
            
            let deltaX = new.x-old.x
            let deltaY = new.y-old.y
            // print("old \(old), new \(new) --- delX \(deltaX), delY \(deltaY)")
            
            guard deltaX != 0 || deltaY != 0 else { return }
            guard let self = self else { return }
            let oldPolar = self.polarSystem.convert(from: old)
            let newPolar = self.polarSystem.convert(from: new)
            // print("old \(oldPolar), new \(newPolar)")
            
            let deltaAngle = newPolar.angle - oldPolar.angle
            let clockwise = (deltaAngle < 0) ? "clockwise" : "counter-clockwise"
            print(clockwise)
        }
    }
    
}

