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
	private let isRunning = Variable(false)
	
	// MARK: - View Controller Life Cycles
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = UIColor.white
		self.title = "Котировки"
		
		configureLayout()
		tableView.register(TickerCell.self, forCellReuseIdentifier: cellIdentifier)
		
		tableView.rx.setDelegate(self).disposed(by: disposeBag)
		tableView.allowsSelection = false
		tableView.rowHeight = 74
		
		isRunning.asObservable()
			.flatMapLatest { isRunning in
				isRunning ? Observable<Int>.timer(0, period: 5, scheduler: MainScheduler.instance) : .empty()
			}
			.asObservable()
			.flatMap { _ -> Observable<[TickerModel]> in
				return self.tickerRequest.sendRequest()
			}
			.bind(to: tableView.rx.items(cellIdentifier: cellIdentifier)) { row, model, cell in
				guard let cell = cell as? TickerCell else { return }
				cell.delegate = self
				cell.ticker = model
			}
			.disposed(by: disposeBag)
		
		NotificationCenter.default.addObserver(self, selector: #selector(changedOrientation), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		self.isRunning.value = true
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		self.isRunning.value = false
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
	
	@objc func changedOrientation(_ notification: Notification) {
		tableView.visibleCells.forEach { ($0 as! TickerCell).setupFrames() }
	}
}

extension TickersVC: TickerCellHeightDelegate {
	
	// MARK: - TickerCellHeightDelegate
	func setHeight(_ height: CGFloat) {
		tableView.rowHeight = height
	}
}

