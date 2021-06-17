//
//  API.swift
//  TBInterview
//
//  Created by Zachary Rhodes on 5/25/21.
//

import Foundation
import Combine

class API {
  var timerCancellable: AnyCancellable?
  var expenseData: AnyPublisher<Data, Error> {
    return expenseDataSubject.eraseToAnyPublisher()
  }
  private var expenseDataSubject = PassthroughSubject<Data, Error>()
  
  init() {
    scheduleExpenseDataPublisherValues()
  }
  
  func fetchMonthlyBudget(completion: @escaping (Float) -> Void) {
    let delay = 1.0
    DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
      DispatchQueue.main.async {
        completion(Float.random(in: 900...1500)) //Originally 500...800, which was always under budget.
      }
    }
  }
  
  private func scheduleExpenseDataPublisherValues() {
    timerCancellable = Timer.publish(every: 5.0, on: .main, in: .common).autoconnect().sink(receiveValue: { [weak self] (output) in
      self?.expenseDataSubject.send(MockData.randomExpenseData())
    })
  }
}
