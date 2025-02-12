//
//  chatt.swift
//  swiftUIChatter
//
//  Created by Nina Sheckler on 1/25/25.
//

import Foundation

struct Chatt: Identifiable {
    var username: String?
    var message: String?
    var id: UUID?
    var timestamp: String?
    var altRow: Bool = true
    @OptionalizedEmpty var audio: String?
    
    // so that we don't need to compare every property for equality
    static func ==(lhs: Chatt, rhs: Chatt) -> Bool {
        lhs.id == rhs.id
    }
}

@propertyWrapper
struct OptionalizedEmpty {
    private var _value: String?
    var wrappedValue: String? {
        get { _value }
        set {
            guard let newValue else {
                _value = nil
                return
            }
            _value = (newValue == "null" || newValue.isEmpty) ? nil : newValue
        }
    }
    
    init(wrappedValue: String?) {
        self.wrappedValue = wrappedValue
    }
}
