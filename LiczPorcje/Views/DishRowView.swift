//
//  DishRowView.swift
//  LiczPorcje
//
//  Created by Kamila Mroziewska on 09/04/2022.
//

import SwiftUI

struct DishRowView: View {
    
    let dish: CalculatedDish
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
            Text(dish.name)
                .font(.subheadline)
                .foregroundColor(.theme.seconderyTextColor)
                .fontWeight(.bold)
            Spacer()
                Text(dish.date.asShortString())
                    .font(.subheadline)
                    .foregroundColor(.theme.seconderyTextColor)
                    .fontWeight(.bold)
            }
            HStack {
                Text("Kuba: \(dish.largerPortion.asStringWith1DecimalPlace())")
                    .font(.title)
                    .foregroundColor(.accentColor)
                    .fontWeight(.bold)
                Spacer()
                Text("Kami: \(dish.smallerPortion.asStringWith1DecimalPlace())")
                    .font(.title)
                    .foregroundColor(.accentColor)
                    .fontWeight(.bold)
            }
        }
        .padding()
    }
}

struct DishRowView_Previews: PreviewProvider {
    static var previews: some View {
        DishRowView(dish: dev.dish)
    }
}
