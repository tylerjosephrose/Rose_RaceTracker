//
//  NewRaceViewController.swift
//  Rose_RaceTracker
//
//  Created by Tyler Rose on 4/5/17.
//  Copyright © 2017 Tyler Rose. All rights reserved.
//

import UIKit

class NewRaceViewController: UIViewController {
	@IBOutlet weak var meetNameInput: UITextField!
	@IBOutlet weak var dateInput: UITextField!
	@IBOutlet weak var hourInput: UITextField!
	@IBOutlet weak var minuteInput: UITextField!
	@IBOutlet weak var secondInput: UITextField!
	@IBOutlet weak var millisecondInput: UITextField!
	@IBOutlet weak var placeInput: UITextField!
	@IBOutlet var toolbar: UIToolbar!
	
	private let datePicker = UIDatePicker()
	var currentEvent: Event!
	

	@IBAction func meetPicked(_ sender: UITextField) {
		sender.inputAccessoryView = toolbar
	}
	
	@IBAction func datePicked(_ sender: UITextField) {
		datePicker.datePickerMode = .date
		dateInput.inputAccessoryView = toolbar
		dateInput.inputView = datePicker
	}
	
	@IBAction func dateChanged(_ sender: UITextField) {
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .medium
		dateInput.text = dateFormatter.string(from: datePicker.date)
	}

	@IBAction func userClickedDone(_ sender: UIBarButtonItem) {
		view.endEditing(true)
	}

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
    // MARK: - Navigation
	
	override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
		// Check if we have all the information we need to save
		if identifier == "SaveRace" {
			if meetNameInput.text! == "" {
				let alert = UIAlertController()
				alert.title = "You have not entered all the required fields"
				alert.message = "Please Enter the name of the meet"
				let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
				alert.addAction(action)
				present(alert, animated: true, completion: nil)
				return false
			} else if dateInput.text! == "" {
				let alert = UIAlertController()
				alert.title = "You have not entered all the required fields"
				alert.message = "Please Enter the date of the race"
				let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
				alert.addAction(action)
				present(alert, animated: true, completion: nil)
				return false
			}else if secondInput.text! == "" {
				let alert = UIAlertController()
				alert.title = "You have not entered all the required fields"
				alert.message = "Please Enter the seconds of the time"
				let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
				alert.addAction(action)
				present(alert, animated: true, completion: nil)
				return false
			}else if millisecondInput.text! == "" {
				let alert = UIAlertController()
				alert.title = "You have not entered all the required fields"
				alert.message = "Please Enter the milliseconds of the time"
				let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
				alert.addAction(action)
				present(alert, animated: true, completion: nil)
				return false
			}
		}
		return true
	}

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
		
		if segue.identifier == "SaveRace" {
			var time: TimeInterval
			if hourInput.text! != "" {
				var num = TimeInterval(hourInput.text!)! * 3600 + TimeInterval(minuteInput.text!)! * 60
				num = num + TimeInterval(secondInput.text!)! + TimeInterval(millisecondInput.text!)! / 100
				time = num
			} else if minuteInput.text! != "" {
				let num = TimeInterval(minuteInput.text!)! * 60 + TimeInterval(secondInput.text!)! + TimeInterval(millisecondInput.text!)! / 100
				time = num
			} else {
				let num = TimeInterval(secondInput.text!)! + TimeInterval(millisecondInput.text!)! / 100
				time = num
			}
			if placeInput.text! == "" {
				currentEvent.add(race: Race(date: datePicker.date, location: meetNameInput.text!, event: currentEvent.getType(), time: time))
			} else {
				currentEvent.add(race: Race(date: datePicker.date, location: meetNameInput.text!, event: currentEvent.getType(), time: time, place: Int(placeInput.text!)!))
			}
		}
    }
}
