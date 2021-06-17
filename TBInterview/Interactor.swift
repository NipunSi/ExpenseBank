//
//  Interactor.swift
//  TBInterview
//
//  Created by Zachary Rhodes on 5/25/21.
//

import Foundation
import Combine

class Interactor {
    let api: API

    let timer = API().timerCancellable
    let expenseData = API().expenseData
    var allExpenses = Set<AnyCancellable>()
    
    var expenses = [Expense]()
    var budget = Float()
    var totalSpent = Float()
    var isOverBudget = Bool()
    var mostSpentCategory = String()
    
    //Get and format the expense data that comes from the API every 5 seconds. Decode the data and run the next functions.
    func getExpenses() {
       api.expenseData.sink { (completion) in
            switch completion {
            case .finished:
                break
            case .failure(let err):
                print("Error with sink: \(err.localizedDescription)")
            }
        } receiveValue: { (data) in
                do {
                    self.expenses = try JSONDecoder().decode([Expense].self, from: data)                    
                    self.getBudget()
                    
                } catch {
                    print("Error decoding: \(error)")
                }
        }
       .store(in: &allExpenses)
    }
    
    //Use the API to get the monthly budget. Then get the total amount spent and determine the most spent category
    func getBudget() {
        api.fetchMonthlyBudget { (newBudget) in
            self.budget = newBudget
            
            self.getTotalSpent()
            self.getMostSpentCategory()
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
    }
    
    //Get the sum of all the expenses amounts and determine whethere it's over or under the budget
    func getTotalSpent() {
        totalSpent = expenses.map({$0.amount}).reduce(0, +)
        isOverBudget = totalSpent > budget
        print("Spent: $\(totalSpent) - Budget: $\(budget)")
    }
    
    //Get the sum of each categories amount spent. Compare the sums and determine which category had the highest.
    func getMostSpentCategory() {
        var amounts = [String: Float]()
        
        for expense in expenses {
            if let category = expense.category {
                amounts[category] = (amounts[category] ?? 0) + expense.amount
            }
        }
        
        let max = amounts.max { a, b in a.value < b.value }        
        switch max?.key {
        case "food":
            mostSpentCategory = "Food 🍕"
        case "travel":
            mostSpentCategory = "Travel ✈️"
        case "software":
            mostSpentCategory = "Software 💻"
        default:
            mostSpentCategory = "None"
        }
        
    }
    
    //Check the current month and return it as a string.
    func getCurrentMonthString() -> String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        return dateFormatter.string(from: now)
    }
    
    init(api: API) {
        self.api = api
    }
}
