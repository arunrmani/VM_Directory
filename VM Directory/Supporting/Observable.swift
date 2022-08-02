//
//  Observable.swift
//  VM Directory
//
//  Created by Arun R Mani on 01/08/2022.
//

import Foundation

class Observable<T> {
    var value: T{
        didSet{
            listener?(value)
        }
    }
    init(_ value: T){
        self.value = value
    }
    
    private var listener: ((T) -> Void)?
    
    func bind(_ listener: @escaping (T) -> Void){
        listener(value)
        self.listener = listener
    }
}
