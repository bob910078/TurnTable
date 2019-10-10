//
//  Observable.swift
//  TurnTable
//
//  Created by Bob Chang on 2019/10/10.
//  Copyright © 2019 Dandelion. All rights reserved.
//

/*
 感謝 Design Pattern 讀書會
 2019.09.29 Jack
 */

import Foundation

class Observable<T> {
    
    typealias Listener = (T, T) -> ()
    
    var listener: Listener?
    
    private var lagacy: T?
    
    var value: T {
        didSet {
            if let old = lagacy {
                listener?(old, value)
            } else {
                listener?(value, value)
            }
            lagacy = value
        }
    }
        
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
}

