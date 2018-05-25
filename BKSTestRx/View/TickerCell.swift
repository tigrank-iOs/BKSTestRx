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
	
	private let tickerNameLabel = UILabel()
	private let lastTitleLabel = UILabel()
	private let lastLabel = UILabel()
	private let changeTitleLabel = UILabel()
	private let changeLabel = UILabel()
	private let highestTitleLabel = UILabel()
	private let highestLabel = UILabel()
	
	private let mainStackView = UIStackView()
	private let indicatorsStackView = UIStackView()
	private let lastStackView = UIStackView()
	private let changeStackView = UIStackView()
	private let highestStackView = UIStackView()
	
	// MARK: - Functions
	func setupCellWithTicker(_ ticker: TickerModel) {
		self.ticker = ticker
		setupLabels()
		setupStackViews()
		setupLayout()
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
	
	private func setupStackViews() {
		let requiredWidth = self.contentView.bounds.size.width / 3
		
		lastStackView.addArrangedSubview(lastTitleLabel)
		lastStackView.addArrangedSubview(lastLabel)
		lastStackView.axis = .vertical
		lastStackView.alignment = .fill
		lastStackView.distribution = .fillEqually
		lastStackView.spacing = 2
		lastStackView.bounds.size.width = requiredWidth
		
		changeStackView.addArrangedSubview(changeTitleLabel)
		changeStackView.addArrangedSubview(changeLabel)
		changeStackView.axis = .vertical
		changeStackView.alignment = .fill
		changeStackView.distribution = .fillEqually
		changeStackView.spacing = 2
		changeStackView.bounds.size.width = requiredWidth
		
		highestStackView.addArrangedSubview(highestTitleLabel)
		highestStackView.addArrangedSubview(highestLabel)
		highestStackView.axis = .vertical
		highestStackView.alignment = .fill
		highestStackView.distribution = .fillEqually
		highestStackView.spacing = 2
		highestStackView.bounds.size.width = requiredWidth
		
		indicatorsStackView.addArrangedSubview(lastStackView)
		indicatorsStackView.addArrangedSubview(changeStackView)
		indicatorsStackView.addArrangedSubview(highestStackView)
		indicatorsStackView.axis = .horizontal
		indicatorsStackView.alignment = .fill
		indicatorsStackView.distribution = .fillEqually
		indicatorsStackView.spacing = 0
		indicatorsStackView.bounds.size.width = self.contentView.bounds.width
		
		mainStackView.addArrangedSubview(tickerNameLabel)
		mainStackView.addArrangedSubview(indicatorsStackView)
		mainStackView.axis = .vertical
		mainStackView.alignment = .fill
		mainStackView.distribution = .fillEqually
		mainStackView.spacing = 0
		mainStackView.bounds.size.width = self.contentView.bounds.width
	}
	
	private func setupLayout() {
		self.contentView.addSubview(mainStackView)
		mainStackView.translatesAutoresizingMaskIntoConstraints = false
		mainStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor)
		mainStackView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
		mainStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
		mainStackView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor)
	}
	
	

}
