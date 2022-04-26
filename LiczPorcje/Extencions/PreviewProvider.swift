//
//  PreviewProvider.swift
//  LiczPorcje
//
//  Created by Kamila Mroziewska on 09/04/2022.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperProvider {
        return DeveloperProvider.instance
    }
}

class DeveloperProvider {
    static let instance = DeveloperProvider()
    
    let dish = CalculatedDish(name: "Spaghetti ratunkowe", largerPortion: 230, smallerPortion: 170, date: Date())
    
}
