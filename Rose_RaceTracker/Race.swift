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
	private var raceTime: time_t!
	private var racePlace: Int?
	
	init(date: Date, location: String, event: String, time: time_t) {
		super.init()
		
		meetDate = date
		meetLocation = location
		eventType = event
		raceTime = time
	}
	
	init(date: Date, location: String, event: String, time: time_t, place: Int) {
		super.init()
		
		meetDate = date
		meetLocation = location
		eventType = event
		raceTime = time
		racePlace = place
	}
	
	func getTime() -> time_t {
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
		raceTime = aDecoder.decodeObject(forKey: "raceTime") as! time_t
		racePlace = aDecoder.decodeObject(forKey: "racePlace") as? Int
	}
	
}
