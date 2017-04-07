//
//  ElapsedTimeFormatter.swift
//  Rose_RaceTracker
//
//  Created by Tyler Rose on 4/6/17.
//  Copyright © 2017 Tyler Rose. All rights reserved.
//

import UIKit
import Charts

class ElapsedTimeFormatter: NSObject, IValueFormatter {
	func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
		let time = TimeInterval(value)
		let hours = floor(time/3600)
		let minutes = floor(time / 60) - hours * 60
		let seconds = floor(time) - hours * 3600 - minutes * 60
		let milliseconds = round(time.truncatingRemainder(dividingBy: 1.0) * 100)
		if hours > 0 {
			return String(Int(hours)) + ":" + String(format:"%02.0f", Int(minutes)) + ":" + String(format:"%02.0f", seconds) + "." + String(format: "%02.0f", milliseconds)
		} else if minutes > 0 {
			return String(Int(minutes)) + ":" + String(format:"%02.0f", seconds) + "." + String(format:"%02.0f", milliseconds)
		} else {
			return String(Int(seconds)) + "." + String(format:"%02.0f", milliseconds)
		}
	}
}

class ElapsedTimeAxisFormatter: IndexAxisValueFormatter {
	override func stringForValue(_ value: Double, axis: AxisBase?) -> String {
		let time = TimeInterval(value)
		let hours = floor(time/3600)
		let minutes = floor(time / 60) - hours * 60
		let seconds = floor(time) - hours * 3600 - minutes * 60
		let milliseconds = round(time.truncatingRemainder(dividingBy: 1.0) * 100)
		if hours > 0 {
			return String(Int(hours)) + ":" + String(format:"%02.0f", Int(minutes)) + ":" + String(format:"%02.0f", seconds) + "." + String(format: "%02.0f", milliseconds)
		} else if minutes > 0 {
			return String(Int(minutes)) + ":" + String(format:"%02.0f", seconds) + "." + String(format:"%02.0f", milliseconds)
		} else {
			return String(Int(seconds)) + "." + String(format:"%02.0f", milliseconds)
		}
	}
}
