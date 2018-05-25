//
//  TickerRequest.swift
//  BKSTestRx
//
//  Created by Тигран on 25.05.2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import RxSwift
import RxCocoa
import SwiftyJSON

class TickerRequest {
	private let baseURL = URL(string: "https://poloniex.com/public?command=returnTicker")
	private var request: URLRequest
	
	init() {
		self.request = URLRequest(url: baseURL!)
	}
	
	func sendRequest() -> Observable<[TickerModel]> {
		return Observable.create { [weak self] observer in
			guard let s = self else { return Disposables.create() }
			let task = URLSession.shared.dataTask(with: s.request, completionHandler: { data, response, error in
				if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
					let json = JSON(data).dictionaryValue
					let model = TickerModelContainer(json)
					let returnModel = model.tickers
					observer.onNext(returnModel)
					observer.onCompleted()
				}
				if let error = error {
					print(error.localizedDescription)
					observer.onError(error)
				}
			})
			task.resume()
			return Disposables.create {
				task.cancel()
			}
		}
	}
}


