//
//  CalculatedDishesView.swift
//  LiczPorcje
//
//  Created by Kamila Mroziewska on 07/04/2022.
//

import SwiftUI

struct CalculatedDishesView: View {
    
    @ObservedObject var vm: HomeViewModel
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack() {
            topLabel
            List(vm.calculatedDishes, id: \.date) { dish in
                DishRowView(dish: dish)
                .swipeActions {
                    Button {
                        vm.removeFromCalculatedDishes(item: dish)
                    } label: {
                        Image(systemName: "trash.fill")
                    }
                    .tint(.red)
                }
            }
            .listStyle(.plain)
        }
        
    }
}

struct CalculatedDishesView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatedDishesView(vm: HomeViewModel())
        CalculatedDishesView(vm: HomeViewModel())
            .preferredColorScheme(.dark)
    }
}

extension CalculatedDishesView {
    private var topLabel: some View {
        HStack {
            Text("Zapisane dania")
                .font(.title2)
                .fontWeight(.light)
                .foregroundColor(.theme.accent)
            Spacer()
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.title)
                    .foregroundColor(.theme.accent)
            }
        }
        .padding(.horizontal)
        .padding(.bottom)
        .background(Color.theme.seconderyTextColor.opacity(0.1).ignoresSafeArea())
    }
}
