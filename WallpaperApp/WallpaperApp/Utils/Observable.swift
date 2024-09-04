//
//  Observable.swift
//  WallpaperApp
//
//  Created by Şükrü on 25.08.2024.
//

import Foundation

class Observable<T> {
    private var _value: T? {
        didSet {
            _callback?(_value)
        }
    }
    
    var value: T? {
        get {
            return _value
        }
        set {
            _value = newValue
        }
    }
    
    private var _callback: ((T?) -> Void)?
    
    func bind(callback: @escaping (T?) -> Void) {
        _callback = callback
        callback(_value)
    }
}
