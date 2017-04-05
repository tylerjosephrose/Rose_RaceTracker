//
//  Event.swift
//  Rose_RaceTracker
//
//  Created by Tyler Rose on 4/4/17.
//  Copyright © 2017 Tyler Rose. All rights reserved.
//

import UIKit

class Event: NSObject, NSCoding {
	private var eventType: String!
	private var races = [Race]()
	private var personalRecord: TimeInterval?
	private var seasonBest = [Int : TimeInterval]()
	private let calendar = Calendar.current
	
	init(type: String) {
		super.init()
		
		eventType = type
	}
	
	func getType() -> String {
		return eventType
	}
	
	func getPR() -> TimeInterval? {
		return personalRecord
	}
	
	func getSB() -> [Int: TimeInterval] {
		return seasonBest
	}
	
	func getRaces() -> [Race] {
		return races
	}
	
	func getCountOfRaces() -> Int {
		return races.count
	}
	
	func getNumOfYears() -> Int {
		return seasonBest.count
	}
	
	func add(race: Race) {
		races.append(race)
		sortByDate()
		determinePR()
		determineSB()
		Person.getInstance().saveEvents()
	}
	
	func removeRace(at i: Int) {
		races.remove(at: i)
		determinePR()
		Person.getInstance().saveEvents()
	}
	
	private func sortByDate() {
		races.sort(by: sortDateInternal(r1:r2:))
	}
	
	private func sortDateInternal(r1: Race, r2: Race) -> Bool {
		if r1.getDate() == r2.getDate() {
			return r1.getTime() < r2.getTime()
		} else {
			return r1.getDate() < r2.getDate()
		}
	}
	
	private func determinePR() {
		if races.count == 0 {
			personalRecord = nil
		}
		if races.count == 1 {
			personalRecord = races[0].getTime()
		}
		var fastest = races[0].getTime()
		for race in races {
			if race.getTime() < fastest {
				fastest = race.getTime()
			}
		}
		personalRecord = fastest
	}
	
	private func determineSB() {
		for race in races {
			let year = calendar.component(.year, from: race.getDate())
			if seasonBest[year] == nil {
				seasonBest[year] = race.getTime()
			} else if seasonBest[year]! > race.getTime() {
				seasonBest[year] = race.getTime()
			}
		}
	}
	
	
	// Encoding/Decoding
	func encode(with aCoder: NSCoder) {
		aCoder.encode(eventType, forKey: "eventType")
		aCoder.encode(races, forKey: "races")
		aCoder.encode(personalRecord, forKey: "personalRecord")
		aCoder.encode(seasonBest, forKey: "seasonBest")
	}
	
	required init?(coder aDecoder: NSCoder) {
		eventType = aDecoder.decodeObject(forKey: "eventType") as! String
		races = aDecoder.decodeObject(forKey: "races") as! [Race]
		personalRecord = aDecoder.decodeObject(forKey: "personalRecord") as? TimeInterval
		seasonBest = aDecoder.decodeObject(forKey: "seasonBest") as! [Int : TimeInterval]
	}
}
