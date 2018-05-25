//
//  TickerModel.swift
//  BKSTestRx
//
//  Created by Тигран on 25.05.2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import SwiftyJSON
import RxSwift

struct TickerModel {
	let name: String
	let last: Double
	let change: Double
	let highest: Double
	
	init(_ name: String, json: [String : JSON]) {
		self.name = name
		last = json["last"]!.doubleValue
		change = json["percentChange"]!.doubleValue
		highest = json["highestBid"]!.doubleValue
	}
	
	func getPercentChange() -> String {
		let percent = Double(Int(change * 100)) / 100
		return "\(percent.description)%"
	}
	
	func isChangePositive() -> Bool {
		return change >= 0 ? true : false
	}
}

struct TickerModelContainer {
	let tickers: [TickerModel]
	
	init(_ json: [String : JSON]) {
		tickers = json.compactMap { TickerModel($0.key, json: $0.value.dictionaryValue) }
	}
}
