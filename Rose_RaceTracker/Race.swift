//
//  Race.swift
//  Rose_RaceTracker
//
//  Created by Tyler Rose on 4/4/17.
//  Copyright © 2017 Tyler Rose. All rights reserved.
//

import UIKit

class Race: NSObject, NSCoding {

	private var meetDate: Date!
	private var meetLocation: String!
	private var eventType: String!
	private var raceTime: TimeInterval!
	private var racePlace: Int?
	
	init(date: Date, location: String, event: String, time: TimeInterval) {
		super.init()
		
		meetDate = date
		meetLocation = location
		eventType = event
		raceTime = time
	}
	
	init(date: Date, location: String, event: String, time: TimeInterval, place: Int) {
		super.init()
		
		meetDate = date
		meetLocation = location
		eventType = event
		raceTime = time
		racePlace = place
	}
	
	func getTime() -> TimeInterval {
		return raceTime
	}
	
	func getDate() -> Date {
		return meetDate
	}
	
	func getLocation() -> String {
		return meetLocation
	}
	
	func getEvent() -> String {
		return eventType
	}
	
	func getPlace() -> Int {
		return racePlace!
	}
	
	static func timeToString(time: TimeInterval) -> String {
		let hours = floor(time/3600)
		let minutes = floor(time / 60) - hours * 60
		let seconds = time - hours * 3600 - minutes * 60
		if hours > 0 {
			return String(Int(hours)) + ":" + String(Int(minutes)) + ":" + String(format:"%.2f", seconds)
		} else if minutes > 0 {
			return String(Int(minutes)) + ":" + String(format:"%.2f", seconds)
		} else {
			return String(format:"%.2f", seconds)
		}
	}
	
	// Encoding/Decoding
	func encode(with aCoder: NSCoder) {
		aCoder.encode(meetDate, forKey: "meetDate")
		aCoder.encode(meetLocation, forKey: "meetLocation")
		aCoder.encode(eventType, forKey: "eventType")
		aCoder.encode(raceTime, forKey: "raceTime")
		aCoder.encode(racePlace, forKey: "racePlace")
	}
	
	required init?(coder aDecoder: NSCoder) {
		meetDate = aDecoder.decodeObject(forKey: "meetDate") as! Date
		meetLocation = aDecoder.decodeObject(forKey: "meetLocation") as! String
		eventType = aDecoder.decodeObject(forKey: "eventType") as! String
		raceTime = aDecoder.decodeObject(forKey: "raceTime") as! TimeInterval
		racePlace = aDecoder.decodeObject(forKey: "racePlace") as? Int
	}
	
}
