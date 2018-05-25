//
//  TickerCell.swift
//  BKSTestRx
//
//  Created by Тигран on 25.05.2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import UIKit

class TickerCell: UITableViewCell {
	
	// MARK: - Variables
	private var ticker: TickerModel?
	private var rowHeight: CGFloat = 88
	
	private let tickerNameLabel = UILabel()
	private let lastTitleLabel = UILabel()
	private let lastLabel = UILabel()
	private let changeTitleLabel = UILabel()
	private let changeLabel = UILabel()
	private let highestTitleLabel = UILabel()
	private let highestLabel = UILabel()
	
	// MARK: - Functions
	func setupCellWithTicker(_ ticker: TickerModel) {
		self.ticker = ticker
		[tickerNameLabel, lastTitleLabel, lastLabel, changeTitleLabel, changeLabel, highestTitleLabel, highestLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false; contentView.addSubview($0) }
		setupLabels()
		setupFrames()
	}
	
	// MARK: - Private Functions
	private func setupLabels() {
		guard let ticker = ticker else { return }
		
		tickerNameLabel.text = ticker.name
		tickerNameLabel.textColor = UIColor(red: 11/255, green: 112/255, blue: 118/255, alpha: 1)
		tickerNameLabel.font = UIFont(name: "Roboto-Bold", size: 18)
		tickerNameLabel.textAlignment = .center
		
		lastTitleLabel.text = "Last"
		lastTitleLabel.textColor = .black
		lastTitleLabel.font = UIFont(name: "Roboto-Light", size: 12)
		lastTitleLabel.textAlignment = .center
		
		lastLabel.text = "\(ticker.last.description)"
		lastLabel.textColor = .black
		lastLabel.font = UIFont(name: "Roboto-Medium", size: 12)
		lastLabel.textAlignment = .center
		
		changeTitleLabel.text = "Change"
		changeTitleLabel.textColor = .black
		changeTitleLabel.font = UIFont(name: "Roboto-Light", size: 12)
		changeTitleLabel.textAlignment = .center
		
		changeLabel.text = ticker.getPercentChange()
		ticker.isChangePositive() ? (changeLabel.textColor = .green) : (changeLabel.textColor = .red)
		changeLabel.font = UIFont(name: "Roboto-Medium", size: 12)
		changeLabel.textAlignment = .center
		
		highestTitleLabel.text = "Highest"
		highestTitleLabel.textColor = .black
		highestTitleLabel.font = UIFont(name: "Roboto-Light", size: 12)
		highestTitleLabel.textAlignment = .center
		
		highestLabel.text = "\(ticker.highest.description)"
		highestLabel.textColor = .black
		highestLabel.font = UIFont(name: "Roboto-Medium", size: 12)
		highestLabel.textAlignment = .center
	}
	
	func setupFrames() {
		setTicketNameLabelFrame()
		setLastTitleLabelFrame()
		setLastLabelFrame()
		setChangeTitleLabelFrame()
		setChangeLabelFrame()
		setHighestTitleLabelFrame()
		setHighestLabelFrame()
	}
	
	private func setTicketNameLabelFrame() {
		let labelSize = CGSize(width: contentView.bounds.width, height: rowHeight / 2)
		let labelX = 0
		let labelY = 0
		let labelOrigin = CGPoint(x: labelX, y: labelY)
		tickerNameLabel.frame = CGRect(origin: labelOrigin, size: labelSize)
	}
	
	private func setLastTitleLabelFrame() {
		let labelSize = CGSize(width: contentView.bounds.width / 3, height: rowHeight / 4)
		let labelX = CGFloat(0)
		let labelY = rowHeight / 2
		let labelOrigin = CGPoint(x: labelX, y: labelY)
		lastTitleLabel.frame = CGRect(origin: labelOrigin, size: labelSize)
	}
	
	private func setLastLabelFrame() {
		let labelSize = CGSize(width: contentView.bounds.width / 3, height: rowHeight / 4)
		let labelX = CGFloat(0)
		let labelY = rowHeight / 2 + rowHeight / 4
		let labelOrigin = CGPoint(x: labelX, y: labelY)
		lastLabel.frame = CGRect(origin: labelOrigin, size: labelSize)
	}
	
	private func setChangeTitleLabelFrame() {
		let labelSize = CGSize(width: contentView.bounds.width / 3, height: rowHeight / 4)
		let labelX = contentView.bounds.width / 3
		let labelY = rowHeight / 2
		let labelOrigin = CGPoint(x: labelX, y: labelY)
		changeTitleLabel.frame = CGRect(origin: labelOrigin, size: labelSize)
	}
	
	private func setChangeLabelFrame() {
		let labelSize = CGSize(width: contentView.bounds.width / 3, height: rowHeight / 4)
		let labelX = contentView.bounds.width / 3
		let labelY = rowHeight / 2 + rowHeight / 4
		let labelOrigin = CGPoint(x: labelX, y: labelY)
		changeLabel.frame = CGRect(origin: labelOrigin, size: labelSize)
	}
	
	private func setHighestTitleLabelFrame() {
		let labelSize = CGSize(width: contentView.bounds.width / 3, height: rowHeight / 4)
		let labelX = contentView.bounds.width / 3 * 2
		let labelY = rowHeight / 2
		let labelOrigin = CGPoint(x: labelX, y: labelY)
		highestTitleLabel.frame = CGRect(origin: labelOrigin, size: labelSize)
	}
	
	private func setHighestLabelFrame() {
		let labelSize = CGSize(width: contentView.bounds.width / 3, height: rowHeight / 4)
		let labelX = contentView.bounds.width / 3 * 2
		let labelY = rowHeight / 2 + rowHeight / 4
		let labelOrigin = CGPoint(x: labelX, y: labelY)
		highestLabel.frame = CGRect(origin: labelOrigin, size: labelSize)
	}
}
