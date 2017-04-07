//
//  ImportViewController.swift
//  Rose_RaceTracker
//
//  Created by Tyler Rose on 4/6/17.
//  Copyright © 2017 Tyler Rose. All rights reserved.
//

import UIKit

class ImportViewController: UIViewController, UITextViewDelegate {
	
	@IBOutlet weak var milesplitText: UITextView!
	
	var newEvents = [Event]()
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		milesplitText.delegate = self as UITextViewDelegate
    }
	
	func textViewDidBeginEditing(_ textView: UITextView) {
		milesplitText.text = ""
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	private func stringToTime(_ string: String) -> TimeInterval {
		let set = CharacterSet(charactersIn: ":.")
		var strArray = string.components(separatedBy: set)
		var time: TimeInterval
		if strArray.count > 4 || strArray.count == 1 {
			return 0.0
		}
		if strArray.count == 4 {
			var num = TimeInterval(strArray[0])! * 3600 + TimeInterval(strArray[1])! * 60
			num = num + TimeInterval(strArray[2])! + TimeInterval(strArray[3])! / 100
			time = num
		} else if strArray.count == 3 {
			let num = TimeInterval(strArray[0])! * 60 + TimeInterval(strArray[1])! + TimeInterval(strArray[2])! / 100
			time = num
		} else {
			let num = TimeInterval(strArray[0])! + TimeInterval(strArray[1])! / 100
			time = num
		}
		return time
	}
	
	private func stringToDate(_ string: String, round: String) -> Date {
		var strArray = string.components(separatedBy: "-")
		let dateformatter = DateFormatter()
		dateformatter.dateStyle = .medium
		print(string)
		if strArray.count == 1 {
			return dateformatter.date(from: strArray[0])!
		} else if strArray.count == 2 {
			if round == "Prelims" {
				return dateformatter.date(from: strArray[0])!
			} else {
				return dateformatter.date(from: strArray[1])!
			}
		} else {
			return Date()
		}
	}
	
	private func filterArray(_ array: [String]) -> [String] {
		var arr = array
		var i = 0
		while i != arr.endIndex {
			let test2 = Int(arr[i])
			// assume this is a year so remove it
			if arr[i].characters.count == 4 && test2 != nil {
				arr.remove(at: i)
			}
			i += 1
		}
		return arr
	}
	
	private func parseText() {
		let localText = milesplitText.text
		var textArray = localText!.components(separatedBy: "\n")
		textArray = filterArray(textArray)
		for i in 0..<textArray.count {
			print(String(i) + ": " + textArray[i])
			if textArray[i] == "MEET" {
				newEvents.append(Event(type: textArray[i - 2]))
			}
			if textArray[i] == "Graph" || textArray[i] == ">" {
				if i + 6 < textArray.endIndex {
					if textArray[i + 3] == "MEET" {
						// This must be the start of a new event
						continue
					}
					let time = stringToTime(textArray[i + 1])
					let date = stringToDate(textArray[i + 4], round: textArray[i + 6])
					let endIndex = textArray[i + 5].index(textArray[i + 5].endIndex, offsetBy: -2)
					let place = Int(textArray[i + 5].substring(to: endIndex))
					newEvents[newEvents.count - 1].add(race: Race(date: date, location: textArray[i + 3], event: newEvents[newEvents.count - 1].getType(), time: time, place: place!))
				}
			}
		}
		//print("newEvents: " + String(newEvents.count))
	}
	
	private func indexBefore(string: String, search: String, options: String.CompareOptions = .literal) -> String.Index? {
		return string.range(of: search, options: options)?.lowerBound
	}
	
	private func indexAfter(string: String, search: String, options: String.CompareOptions = .literal) -> String.Index? {
		return string.range(of: search, options: options)?.upperBound
	}
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
		if segue.identifier == "ReplaceImportSegue" {
			parseText()
			if newEvents.count == 0 {
				return
			}
			let person = Person.getInstance()
			for _ in 0..<person.getCountOfEvents() {
				person.removeEvent(atIndex: 0)
			}
			for i in 0..<newEvents.count {
				person.addEvent(event: newEvents[i])
			}
		}
		if segue.identifier == "AddImportSegue" {
			parseText()
			let person = Person.getInstance()
			for i in 0..<newEvents.count {
				person.addEvent(event: newEvents[i])
			}
		}
    }
}

extension String {
	func index(of string: String, options: CompareOptions = .literal) -> Index? {
		return range(of: string, options: options)?.upperBound
	}
}
