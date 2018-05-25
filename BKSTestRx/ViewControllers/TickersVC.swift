//
//  TickersVC.swift
//  BKSTestRx
//
//  Created by Тигран on 24.05.2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import RxSwift
import RxCocoa

class TickersVC: UIViewController, UITableViewDelegate {
	
	// MARK: - Varibales
	private let tableView = UITableView()
	private let cellIdentifier = "tickerCell"
	private let tickerRequest = TickerRequest()
	private let disposeBag = DisposeBag()
	
	// MARK: - View Controller Life Cycles
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = UIColor.white
		self.title = "Котировки"
		
		tableView.register(TickerCell.self, forCellReuseIdentifier: cellIdentifier)
		configureLayout()
		
		tableView.delegate = self
		tableView.allowsSelection = false
		tableView.rowHeight = 88
		
		Observable<Int>.timer(0, period: 5, scheduler: MainScheduler.instance)
			.asObservable()
			.flatMap { _ -> Observable<[TickerModel]> in
				return self.tickerRequest.sendRequest()
			}
			.bind(to: tableView.rx.items(cellIdentifier: cellIdentifier)) { row, model, cell in
				guard let cell = cell as? TickerCell else { return }
				cell.setupCellWithTicker(model)
			}
			.disposed(by: disposeBag)
		
	}
	
	// MARK: - Private Functions
	private func configureLayout() {
		view.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
									 tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
									 tableView.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
									 tableView.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor)])
		tableView.contentInset.bottom = view.layoutMargins.bottom
	}
}

