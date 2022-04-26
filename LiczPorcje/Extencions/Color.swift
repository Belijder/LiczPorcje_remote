//
//  Color.swift
//  LiczPorcje
//
//  Created by Kamila Mroziewska on 05/04/2022.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let seconderyTextColor = Color("SeconderyTextColor")
}
