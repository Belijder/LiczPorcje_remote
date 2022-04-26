//
//  HomeViewModel.swift
//  LiczPorcje
//
//  Created by Kamila Mroziewska on 05/04/2022.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published private(set) var  calculatedDishes: [CalculatedDish] = []
    @Published var largerPortion: Double = 0
    @Published var smallerPortion: Double = 0
    let saveKey = "SavedData"
    var dishName = ""
    var portionsNumber = 0.0
    var dishWeight = 0.0
    
    
    func addToCalculatedDishes() {
        let dish = CalculatedDish(name: dishName, largerPortion: largerPortion, smallerPortion: smallerPortion, date: Date())
        calculatedDishes.append(dish)
        save()
    }
    
    func removeFromCalculatedDishes(item: CalculatedDish) {
        calculatedDishes.removeAll { $0 == item }
        save()
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(calculatedDishes) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    func setDishName(value: String) {
        dishName = value
    }
    
    func calculatePortions(portionsNumber: String, dishWeight: String) {
        setValuesToCalculate(portionsNumber: portionsNumber, dishWeight: dishWeight)
        calculateBiggerPortion()
        calculateSmallerPortion()
    }
    
    func setValuesToCalculate(portionsNumber: String, dishWeight: String) {
        if let portionsValue = Double(portionsNumber) {
            self.portionsNumber = portionsValue
        }
        
        if let dishWeightValue = Double(dishWeight) {
            self.dishWeight = dishWeightValue
        }
    }
    
    func calculateSmallerPortion() {
        if dishWeight != 0 && portionsNumber > 1 {
            let portion = (dishWeight / portionsNumber) * 0.85
            smallerPortion = portion
        }
    }
    
    func calculateBiggerPortion() {
        if dishWeight != 0 && portionsNumber > 1 {
            let portion = (dishWeight / portionsNumber) * 1.15
            largerPortion = portion
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([CalculatedDish].self, from: data) {
                calculatedDishes = decoded
                print(calculatedDishes.count)
                return
            }
        }
        calculatedDishes = []
        print(calculatedDishes.count)
    }
}
