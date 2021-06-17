//
//  MockData.swift
//  TBInterview
//
//  Created by Zachary Rhodes on 5/25/21.
//

import Foundation

enum MockData {
  static func randomExpenseData() -> Data {
    let fileName = ["expenses1", "expenses2", "expenses3"].randomElement()
    return readJSONData(fromFile: fileName!)
  }
  
  static private func readJSONData(fromFile filename: String) -> Data {
    guard let filePath = Bundle.main.url(forResource: filename,
                                         withExtension: "json"),
      let data = NSData(contentsOf: filePath) else {
        return Data()
    }
    return data as Data
  }
}
