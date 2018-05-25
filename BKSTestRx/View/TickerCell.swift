//
//  TickerCell.swift
//  BKSTestRx
//
//  Created by Тигран on 25.05.2018.
//  Copyright © 2018 tigrank. All rights reserved.
//

import UIKit

protocol TickerCellHeightDelegate: class {
	func setHeight(_ height: CGFloat)
}

class TickerCell: UITableViewCell {
	
	// MARK: - Variables
	weak var delegate: TickerCellHeightDelegate?
	
	var ticker: TickerModel?
	
	private let inset: CGFloat = 4
	private let tickerNameLabel = UILabel()
	private let lastTitleLabel = UILabel()
	private let lastLabel = UILabel()
	private let changeTitleLabel = UILabel()
	private let changeLabel = UILabel()
	private let highestTitleLabel = UILabel()
	private let highestLabel = UILabel()
	
	// MARK: - Functions
	override func layoutIfNeeded() {
		[tickerNameLabel, lastTitleLabel, lastLabel, changeTitleLabel, changeLabel, highestTitleLabel, highestLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false; contentView.addSubview($0) }
		setupLabels()
		setupFrames()
		let height = tickerNameLabel.bounds.height + lastTitleLabel.bounds.height + lastLabel.bounds.height + 4 * inset
		delegate?.setHeight(height)
	}
	
//	func setupCellWithTicker(_ ticker: TickerModel) {
//		self.ticker = ticker
//		[tickerNameLabel, lastTitleLabel, lastLabel, changeTitleLabel, changeLabel, highestTitleLabel, highestLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false; contentView.addSubview($0) }
//		setupLabels()
//		setupFrames()
//		let height = tickerNameLabel.bounds.height + lastTitleLabel.bounds.height + lastLabel.bounds.height + 4 * inset
//		delegate?.setHeight(height)
//	}
	
	// MARK: - Private Functions
	private func setupLabels() {
		guard let ticker = ticker else { return }
		
		tickerNameLabel.text = ticker.name
		tickerNameLabel.textColor = UIColor(red: 11/255, green: 112/255, blue: 118/255, alpha: 1)
		tickerNameLabel.font = UIFont(name: "Roboto-Bold", size: 18)
		tickerNameLabel.textAlignment = .center
		
		lastTitleLabel.text = "Last"
		lastTitleLabel.textColor = .black
		lastTitleLabel.font = UIFont(name: "Roboto-Light", size: 15)
		lastTitleLabel.textAlignment = .center
		
		lastLabel.text = "\(ticker.last.description)"
		lastLabel.textColor = .black
		lastLabel.font = UIFont(name: "Roboto-Medium", size: 15)
		lastLabel.textAlignment = .center
		
		changeTitleLabel.text = "Change"
		changeTitleLabel.textColor = .black
		changeTitleLabel.font = UIFont(name: "Roboto-Light", size: 15)
		changeTitleLabel.textAlignment = .center
		
		changeLabel.text = ticker.getPercentChange()
		ticker.isChangePositive() ? (changeLabel.textColor = .green) : (changeLabel.textColor = .red)
		changeLabel.font = UIFont(name: "Roboto-Medium", size: 15)
		changeLabel.textAlignment = .center
		
		highestTitleLabel.text = "Highest"
		highestTitleLabel.textColor = .black
		highestTitleLabel.font = UIFont(name: "Roboto-Light", size: 15)
		highestTitleLabel.textAlignment = .center
		
		highestLabel.text = "\(ticker.highest.description)"
		highestLabel.textColor = .black
		highestLabel.font = UIFont(name: "Roboto-Medium", size: 15)
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
	
	private func getNameLabelSize(text: String, font: UIFont) -> CGSize {
		let maxWidth = frame.width
		let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
		let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
		let width = maxWidth
		let height = CGFloat(rect.size.height)
		let size = CGSize(width: ceil(width), height: ceil(height))
		return size
	}
	
	private func getIndicatorsLabelSize(text: String, font: UIFont) -> CGSize {
		let maxWidth = frame.width / 3
		let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
		let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
		let width = maxWidth
		let height = CGFloat(rect.size.height)
		let size = CGSize(width: ceil(width), height: ceil(height))
		return size
	}
	
	private func setTicketNameLabelFrame() {
		let labelSize = getNameLabelSize(text: tickerNameLabel.text!, font: tickerNameLabel.font)
		let labelX = 0
		let labelY = inset
		let labelOrigin = CGPoint(x: CGFloat(labelX), y: labelY)
		tickerNameLabel.frame = CGRect(origin: labelOrigin, size: labelSize)
	}
	
	private func setLastTitleLabelFrame() {
		let labelSize = getIndicatorsLabelSize(text: lastTitleLabel.text!, font: lastTitleLabel.font)
		let labelX = CGFloat(0)
		let labelY = tickerNameLabel.frame.height + 2 * inset
		let labelOrigin = CGPoint(x: labelX, y: labelY)
		lastTitleLabel.frame = CGRect(origin: labelOrigin, size: labelSize)
	}
	
	private func setLastLabelFrame() {
		let labelSize = getIndicatorsLabelSize(text: lastLabel.text!, font: lastLabel.font)
		let labelX = CGFloat(0)
		let labelY = lastTitleLabel.frame.origin.y + lastTitleLabel.frame.height + inset
		let labelOrigin = CGPoint(x: labelX, y: labelY)
		lastLabel.frame = CGRect(origin: labelOrigin, size: labelSize)
	}
	
	private func setChangeTitleLabelFrame() {
		let labelSize = getIndicatorsLabelSize(text: changeTitleLabel.text!, font: changeTitleLabel.font)
		let labelX = lastTitleLabel.frame.width
		let labelY = tickerNameLabel.frame.height + 2 * inset
		let labelOrigin = CGPoint(x: labelX, y: labelY)
		changeTitleLabel.frame = CGRect(origin: labelOrigin, size: labelSize)
	}
	
	private func setChangeLabelFrame() {
		let labelSize = getIndicatorsLabelSize(text: changeLabel.text!, font: changeLabel.font)
		let labelX = lastTitleLabel.frame.width
		let labelY = changeTitleLabel.frame.origin.y + changeTitleLabel.frame.height + inset
		let labelOrigin = CGPoint(x: labelX, y: labelY)
		changeLabel.frame = CGRect(origin: labelOrigin, size: labelSize)
	}
	
	private func setHighestTitleLabelFrame() {
		let labelSize = getIndicatorsLabelSize(text: highestTitleLabel.text!, font: highestTitleLabel.font)
		let labelX = changeTitleLabel.frame.width + changeTitleLabel.frame.origin.x
		let labelY = tickerNameLabel.frame.height + 2 * inset
		let labelOrigin = CGPoint(x: labelX, y: labelY)
		highestTitleLabel.frame = CGRect(origin: labelOrigin, size: labelSize)
	}
	
	private func setHighestLabelFrame() {
		let labelSize = getIndicatorsLabelSize(text: highestLabel.text!, font: highestLabel.font)
		let labelX = changeTitleLabel.frame.width + changeTitleLabel.frame.origin.x
		let labelY = highestTitleLabel.frame.origin.y + highestTitleLabel.frame.height + inset
		let labelOrigin = CGPoint(x: labelX, y: labelY)
		highestLabel.frame = CGRect(origin: labelOrigin, size: labelSize)
	}
}
