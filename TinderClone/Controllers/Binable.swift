//
//  Binable.swift
//  TinderClone
//
//  Created by admin on 7.04.24.
//

import Foundation

class Bindable<T> {
    
    var value: T? {
        didSet {
            observer? (value)
        }
    }
    var observer: ((T?) ->())?
    
    func bind (observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
}

