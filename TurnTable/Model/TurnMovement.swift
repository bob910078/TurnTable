//
//  TurnMovement.swift
//  TurnTable
//
//  Created by Bob Chang on 2019/12/17.
//  Copyright © 2019 Dandelion. All rights reserved.
//

import Foundation

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
