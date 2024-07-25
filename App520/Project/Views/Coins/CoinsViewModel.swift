//
//  CoinsViewModel.swift
//  App520
//
//  Created by IGOR on 22/07/2024.
//

import SwiftUI
import CoreData

final class CoinsViewModel: ObservableObject {
    
    @Published var currencies: [String] = ["EUR", "USD", "AUD", "CAD", "CHF", "NZD"]
    @Published var currCur = "USD"
    @AppStorage("currentCurrency") var currentCurrency = ""
    
    @Published var photos: [String] = ["c1", "c2", "c3", "c4"]
    @Published var curPh: String = ""
    
    @Published var types: [String] = ["In stock", "Sold"]
    @Published var currentType = "In stock"
    
    @AppStorage("categories") var categories: [String] = ["All"]
    @Published var currentCategory = "All"
    @Published var addCat: String = ""

    
    @AppStorage("amountSale") var amountSale: Int = 0
    @AppStorage("amountPur") var amountPur: Int = 0
    @AppStorage("numCo") var numCo: Int = 0
    
    @Published var calcBalance: Int = 0
    @Published var calcBalanceString: String = ""

    @Published var isAdd: Bool = false
    @Published var isCurr: Bool = false
    @Published var isDetail: Bool = false
    @Published var isDelete: Bool = false
    @Published var isCategories: Bool = false

    @Published var isOn: Bool = false
    
    
    @Published var coPhoto: String = ""
    @Published var coName: String = ""
    @Published var coCat: String = ""
    @Published var coCur: String = ""
    @Published var coSPrice: String = ""
    @Published var coPPrice: String = ""
    @Published var coStatus: String = ""
    
    @Published var coins: [CoinModel] = []
    @Published var selectedCoin: CoinModel?
    
    func addCoin() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "CoinModel", into: context) as! CoinModel

        loan.coPhoto = coPhoto
        loan.coName = coName
        loan.coCat = coCat
        loan.coCur = coCur
        loan.coSPrice = coSPrice
        loan.coPPrice = coPPrice
        loan.coStatus = isOn == true ? "Sold" : "In stock"

        CoreDataStack.shared.saveContext()
    }

    func fetchCoins() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<CoinModel>(entityName: "CoinModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.coins = result.filter{($0.coStatus ?? "") == currentType}

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.coins = []
        }
    }
    
    func calculatePercentage() -> Double {
        
        let value = amountPur
        let maxValue = amountSale
        
        let percentCircle = Double(value) / Double(maxValue) * 100
        
        return percentCircle
    }
    
}

