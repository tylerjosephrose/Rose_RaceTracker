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
	private var racesByDate = [Int : [Race] ]()
	private static var instance: Person?
	
	static var firstInitialize = true
	
	override init() {
		super.init()
		
		loadPerson()
	}
	
	func getEvents() -> [Event] {
		return events
	}
	
	func getCountOfEvents() -> Int {
		return events.count
	}
	
	func getRacesByDate() -> [(key: Int, value: [Race])] {
		racesByDate.removeAll()
		for event in events {
			for race in event.getRaces() {
				let year = Calendar.current.component(.year, from: race.getDate())
				if racesByDate[year] == nil {
					racesByDate[year] = [race]
				} else {
					racesByDate[year]?.append(race)
				}
			}
		}
		return racesByDate.sorted(by: {$0.0 < $1.0})
	}
	
	func addEvent(event: Event) {
		events.append(event)
		saveEvents()
	}
	
	func removeEvent(atIndex i: Int) {
		events.remove(at: i)
		saveEvents()
	}
	
	private func loadPerson() {
		let fileURL = getFileURL()
		
		do {
			try FileManager.default.removeItem(at: fileURL)
		} catch _ as NSError {
			print("Deletion failed")
		}
		if (FileManager.default.fileExists(atPath: fileURL.path)) {
			// Load Contents
			//events.removeAll()
			events = NSKeyedUnarchiver.unarchiveObject(withFile: fileURL.path) as! [Event]
		} else {
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
			dateComponents.day = 20
			date = Calendar.current.date(from: dateComponents)
			time = 1067.36
			e3.add(race: Race(date: date!, location: "Districts", event: e3.getType(), time: time, place: 14))
			dateComponents.day = 27
			date = Calendar.current.date(from: dateComponents)
			time = 1068.09
			e3.add(race: Race(date: date!, location: "Regionals", event: e3.getType(), time: time, place: 33))
			events.append(e3)
			saveEvents()
		}
	}
	
	private func getFileURL() -> URL {
		let dir = try! FileManager.default.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: true)
		let fileURL = dir.appendingPathComponent("RaceTracker.data")
		return fileURL
	}
	
	func saveEvents() {
		let fileURL = getFileURL()
		NSKeyedArchiver.archiveRootObject(events, toFile: fileURL.path)
	}
	
	static func getInstance() -> Person {
		if instance == nil {
			instance = Person()
			firstInitialize = false
		}
		return instance!
	}
}
