//
//  PolarCoordination.swift
//  TurnTable
//
//  Created by Bob Chang on 2019/10/10.
//  Copyright © 2019 Dandelion. All rights reserved.
//

import UIKit

class PolarCoordination {
    
    let origin: CGPoint
    
    init(origin: CGPoint) {
        self.origin = origin
    }
    
    /// 將笛卡爾直角坐標系之座標轉化為極坐標系之座標
    /// - Parameter CartesianPoint: 笛卡爾坐標系之座標表示法
    func convert(from CartesianPoint: CGPoint) -> PolarPoint {
        
        let newOrigin = convertCoordinator(viewCoordinator: origin)
        let newPoint = convertCoordinator(viewCoordinator: CartesianPoint)
        
        let deltaX = newPoint.x - newOrigin.x
        let deltaY = newPoint.y - newOrigin.y
        
        let radius = hypot(deltaX, deltaY)
        let theda = atan2(deltaY, deltaX)
        
        let point = PolarPoint(radius: radius, angle: theda)
        return point
    }
    
    
    /// 轉換 view coodinator 成為 draw coordinator
    // https://developer.apple.com/library/archive/documentation/2DDrawing/Conceptual/DrawingPrintingiOS/GraphicsDrawingOverview/GraphicsDrawingOverview.html
    func convertCoordinator(viewCoordinator vPoint: CGPoint) -> CGPoint {
        return CGPoint(x: vPoint.x, y: -vPoint.y)
    }

    /// 極坐標位置表示法
    struct PolarPoint {
        
        /// 該位置對圓心點的距離
        var radius: CGFloat
        
        /// 該位置對起始角度的量
        var angle: CGFloat
    }


}
