//
//  Slip.swift
//  Your Advice
//
//  Created by Aakash Jha on 11/09/21.
//

import Foundation

struct Slip: Decodable {
    var slip: OneSlip
}

struct OneSlip: Decodable {
    var id: Int32
    var advice: String
}
