//
//  Expense.swift
//  TBInterview
//
//  Created by Nipun Singh on 6/16/21.
//

import Foundation

struct Expense: Decodable {
    let title: String
    let category: String?
    let amount: Float
}
