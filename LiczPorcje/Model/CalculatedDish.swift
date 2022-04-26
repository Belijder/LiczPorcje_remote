//
//  CalculatedDish.swift
//  LiczPorcje
//
//  Created by Kamila Mroziewska on 07/04/2022.
//

import Foundation

struct CalculatedDish: Codable, Equatable {
    let name: String
    let largerPortion: Double
    let smallerPortion: Double
    let date: Date
}
