//
//  String.swift
//  LiczPorcje
//
//  Created by Kamila Mroziewska on 05/04/2022.
//

import Foundation

extension Double {
    func asStringWithNoDecimalPlace() -> String {
        return String(format: "%.0f", self)
    }
}
