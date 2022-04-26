//
//  Date.swift
//  LiczPorcje
//
//  Created by Kamila Mroziewska on 09/04/2022.
//

import Foundation

extension Date {
    func asShortString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self) 
    }
}
