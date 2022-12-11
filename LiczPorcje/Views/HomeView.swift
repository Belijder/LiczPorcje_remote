//
//  ContentView.swift
//  LiczPorcje
//
//  Created by Kamila Mroziewska on 05/04/2022.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = HomeViewModel()
    
    @State private var showSavedList = false
    
    var body: some View {
        ZStack {
            Color.theme.background
            VStack {
                inputSection
                    .onChange(of: vm.dishName) { newValue in
                        vm.checkIfIsAbleToSave()
                    }
                
                outputInfo
                
                saveButton 
            }
            
            appNameAndListButton
        }
        .fullScreenCover(isPresented: $showSavedList) {
            CalculatedDishesView(vm: vm)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
        HomeView()
            .preferredColorScheme(.dark)
    }
}

extension HomeView {
    private var appNameAndListButton: some View {
        VStack {
            HStack(alignment: .center) {
                Text("Policz porcje")
                    .foregroundColor(.theme.accent)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Spacer()
                
                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        showSavedList = true
                    }
                } label: {
                    Image(systemName: showSavedList ? "xmark" : "list.bullet")
                        .font(.title)
                        .foregroundColor(.theme.accent)
                        .padding()
                }
                
            }
            .background(.regularMaterial)
            Spacer()
        }
    }
    
    private var inputSection: some View {
        VStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 5) {
                Text("Nazwa dania")
                    .font(.headline)
                    .foregroundColor(.theme.accent)
                TextField("Podaj nazwę dania...", text: $vm.dishName)
                    .font(vm.dishName == "" ? .subheadline : .headline)
                    .padding()
                    .background(Color.gray.opacity(0.1).cornerRadius(10))
                    .frame(maxWidth: .infinity)
                    .foregroundColor(vm.dishName == "" ? .theme.seconderyTextColor : .theme.accent)
            }
            
            
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Waga dania (g)")
                        .font(.headline)
                        .foregroundColor(.theme.accent)
                    TextField("Podaj wagę...", text: $vm.dishWeightString)
                        .font(vm.dishWeightString == "" ? .subheadline : .headline)
                        .padding()
                        .background(Color.gray.opacity(0.1).cornerRadius(10))
                        .frame(width: UIScreen.main.bounds.width/3, height: 55)
                        .foregroundColor(vm.dishWeightString == "" ? .theme.seconderyTextColor : .theme.accent)
                        .keyboardType(.numberPad)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Liczba porcji")
                        .font(.headline)
                        .foregroundColor(.theme.accent)
                    TextField("Podaj liczbę...", text: $vm.portionsNumberString)
                        .font(vm.portionsNumberString == "" ? .subheadline : .headline)
                        .padding()
                        .background(Color.gray.opacity(0.1).cornerRadius(10))
                        .frame(width: UIScreen.main.bounds.width/3, height: 55)
                        .foregroundColor(vm.portionsNumberString == "" ? .theme.seconderyTextColor : .theme.accent)
                        .keyboardType(.numberPad)    
                }
            }
            
        }
        .padding(.horizontal, 40)
    }
    
    private var outputInfo: some View {
        HStack {
            VStack(alignment: .center, spacing: 10) {
                Text("Porcja Kuby")
                    .foregroundColor(.theme.seconderyTextColor)
                    .font(.title3)
                if vm.largerPortion > 0 {
                    Text("\(vm.largerPortion.asStringWithNoDecimalPlace()) g")
                        .foregroundColor(.theme.accent)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                } else {
                    Text("-")
                        .foregroundColor(.theme.accent)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
            }
            Spacer()
            VStack(alignment: .center, spacing: 10) {
                Text("Porcja Kami")
                    .foregroundColor(.theme.seconderyTextColor)
                    .font(.title3)
                if vm.smallerPortion > 0 {
                    Text("\(vm.smallerPortion.asStringWithNoDecimalPlace()) g")
                        .foregroundColor(.theme.accent)
                        .font(.largeTitle)
                    .fontWeight(.bold)
                } else {
                    Text("-")
                        .foregroundColor(.theme.accent)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                }
            }
        }
        .padding(.horizontal, 60)
        .padding(.vertical, 10)
    }
    
    private var saveButton: some View {
        VStack {
            Button {
                vm.addToCalculatedDishes()
            } label: {
                Text("Zapisz")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.theme.background)
                    .padding()
                    .padding(.horizontal)
                    .background(vm.isAbleToSave ? Color.theme.accent : Color.theme.accent.opacity(0.3))
                    .clipShape(Capsule())
                    
            }
            .disabled(!vm.isAbleToSave)
            
            
            if !vm.isAbleToSave {
                Text("Uzupełnij wszystkie pola, aby móc zapisać obliczenia na potem.")
                    .font(.subheadline)
                    .fontWeight(.light)
                    .padding(.horizontal, 70)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.theme.accent.opacity(1))
                    .frame(height: 50)
            } else {
                Text("")
                    .frame(height: 50)
            }
        }
    }
}

