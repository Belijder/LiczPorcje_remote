//
//  HomeViewModel.swift
//  LiczPorcje
//
//  Created by Kamila Mroziewska on 05/04/2022.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published private(set) var  calculatedDishes: [CalculatedDish] = []
    @Published var largerPortion: Double = 0
    @Published var smallerPortion: Double = 0
    
    @Published var dishName = ""
    @Published var portionsNumberString = ""
    @Published var dishWeightString = ""
    @Published var isAbleToSave = false
    
    let saveKey = "SavedData"
    var cancellables: Set<AnyCancellable> = []
    
    var portionsNumber = 0.0
    var dishWeight = 0.0
    
    //MARK: Saving and removeing data from UserDefaults
    func addToCalculatedDishes() {
        let dish = CalculatedDish(name: dishName, largerPortion: largerPortion, smallerPortion: smallerPortion, date: Date())
        calculatedDishes.append(dish)
        saveDishesInUserDefaults()
    }
    func removeFromCalculatedDishes(item: CalculatedDish) {
        calculatedDishes.removeAll { $0 == item }
        saveDishesInUserDefaults()
    }
    private func saveDishesInUserDefaults() {
        if let encoded = try? JSONEncoder().encode(calculatedDishes) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    private func loadDishesFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([CalculatedDish].self, from: data) {
                calculatedDishes = decoded
                print(calculatedDishes.count)
                return
            }
        calculatedDishes = []
        print(calculatedDishes.count)
        }
    }
    
    //MARK: Calculating Portions
    func calculatePortions() {
        calculateBiggerPortion()
        calculateSmallerPortion()
        print("Waga: \(dishWeight), Porcje: \(portionsNumber)")
        print("Mała \(smallerPortion), duża: \(largerPortion)")
    }
    
    func calculateSmallerPortion() {
        let portion = (dishWeight / portionsNumber) * 0.85
        if portion == 1.0/0.0 {
            smallerPortion = 0.0
        } else {
            smallerPortion = portion
        }
    }
    
    func calculateBiggerPortion() {
        let portion = (dishWeight / portionsNumber) * 1.15
        if portion == 1.0/0.0 {
            largerPortion = 0.0
        } else {
            largerPortion = portion
        }
    }
    
    //MARK: Set Subscribers
    
    func setDishWeightSubscriber() {
        $dishWeightString
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
            .map { (text) -> Double in
                guard let value = Double(text) else { return 0.0 }
                return value
            }
            .sink { [weak self] (value) in
                self?.dishWeight = value
                self?.calculatePortions()
                self?.checkIfIsAbleToSave()
                
            }
            .store(in: &cancellables)
    }
    
    func setPortionsNumberSubscriber() {
        $portionsNumberString
            .debounce(for: .seconds(0.3), scheduler: DispatchQueue.main)
            .map { (text) -> Double in
                guard let value = Double(text) else { return 0.0 }
                return value
            }
            .sink { [weak self] (value) in
                self?.portionsNumber = value
                self?.calculatePortions()
                self?.checkIfIsAbleToSave()
            }
            .store(in: &cancellables)
    }
    
    func checkIfIsAbleToSave() {
        if !dishName.isEmpty && !portionsNumberString.isEmpty && !dishWeightString.isEmpty {
            isAbleToSave = true
        } else {
            isAbleToSave = false
        }
    }
    
    init() {
        loadDishesFromUserDefaults()
        setDishWeightSubscriber()
        setPortionsNumberSubscriber()
    }
}
