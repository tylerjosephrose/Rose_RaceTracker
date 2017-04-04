//
//  Person.swift
//  Rose_RaceTracker
//
//  Created by Tyler Rose on 4/4/17.
//  Copyright © 2017 Tyler Rose. All rights reserved.
//

import UIKit

class Person: NSObject {
	private var events = [Event]()
	private var races = [Race]()
	private var racesByDate = [Int : [Race] ]()
	private static var instance: Person?
	
	override init() {
		super.init()
		
		loadPerson()
	}
	
	func getEvents() -> [Event] {
		return events
	}
	
	private func getRaces() {
		for event in events {
			races.append(contentsOf: event.getRaces())
		}
		sortRaces()
	}
	
	func getCountOfEvents() -> Int {
		return events.count
	}
	
	func getRacesByDate() -> [Int : [Race] ] {
		getRaces()
		for race in races {
			let year = Calendar.current.component(.year, from: race.getDate())
			if racesByDate[year] == nil {
				racesByDate[year] = [race]
			} else {
				racesByDate[year]?.append(race)
			}
		}
		return racesByDate
	}
	
	func addEvent(event: Event) {
		events.append(event)
	}
	
	private func loadPerson() {
		let fileURL = getFileURL()
		/*if (FileManager.default.fileExists(atPath: fileURL.path)) {
			// Load Contents
			events = NSKeyedUnarchiver.unarchiveObject(withFile: fileURL.path) as! [Event]
		} else {*/
			// Create events
			let e1 = Event(type: "400m")
			let e2 = Event(type: "1600m")
			var dateComponents = DateComponents()
			dateComponents.year = 2014
			dateComponents.day = 13
			dateComponents.month = 5
			var date = Calendar.current.date(from: dateComponents)
			var time: TimeInterval
			time = 54.61
			e1.add(race: Race(date: date!, location: "Midwest Athletic Conference Championship", event: e1.getType(), time: time, place: 7))
			events.append(e1)
			dateComponents.year = 2014
			dateComponents.day = 26
			dateComponents.month = 4
			date = Calendar.current.date(from: dateComponents)
			time = 296.55
			e2.add(race: Race(date: date!, location: "Eaton Dean Stoltz Invitational", event: e2.getType(), time: time, place: 5))
			dateComponents.year = 2013
			dateComponents.day = 23
			dateComponents.month = 4
			date = Calendar.current.date(from: dateComponents)
			time = 285.37
			e2.add(race: Race(date: date!, location: "Versailles Tri Meet", event: e2.getType(), time: time, place: 3))
			events.append(e2)
			let e3 = Event(type: "5k")
			dateComponents.year = 2012
			dateComponents.month = 10
			dateComponents.day = 11
			date = Calendar.current.date(from: dateComponents)
			time = 1037.14
			e3.add(race: Race(date: date!, location: "MAC", event: e3.getType(), time: time, place: 13))
			events.append(e3)
			saveContacts()
		//}
	}
	
	private func sortRaces() {
		races.sort(by: sortDateInternal(r1:r2:))
	}
	
	private func sortDateInternal(r1: Race, r2: Race) -> Bool {
		if r1.getDate() == r2.getDate() {
			return r1.getTime() < r2.getTime()
		} else {
			return r1.getDate() < r2.getDate()
		}
	}
	
	private func getFileURL() -> URL {
		let dir = try! FileManager.default.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: true)
		let fileURL = dir.appendingPathComponent("RaceTracker.data")
		return fileURL
	}
	
	private func saveContacts() {
		let fileURL = getFileURL()
		NSKeyedArchiver.archiveRootObject(events, toFile: fileURL.path)
	}
	
	static func getInstance() -> Person {
		if instance == nil {
			instance = Person()
		}
		return instance!
	}
}
