//
//  Person.swift
//  Rose_RaceTracker
//
//  Created by Tyler Rose on 4/4/17.
//  Copyright © 2017 Tyler Rose. All rights reserved.
//

import UIKit

class Person: NSObject, NSCoding {
	private var events = [Event]()
	private var name: String?
	
	func getEvents() -> [Event] {
		return events
	}
	
	func getCountOfEvents() -> Int {
		return events.count
	}
	
	// Encoding/Decoding
	func encode(with aCoder: NSCoder) {
		aCoder.encode(events, forKey: "events")
	}
	
	required init?(coder aDecoder: NSCoder) {
		events = aDecoder.decodeObject(forKey: "events") as! [Event]
	}
	
}
