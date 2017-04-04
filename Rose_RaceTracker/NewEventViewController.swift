//
//  NewEventViewController.swift
//  Rose_RaceTracker
//
//  Created by Tyler Rose on 4/4/17.
//  Copyright © 2017 Tyler Rose. All rights reserved.
//

import UIKit

class NewEventViewController: UIViewController {
	@IBOutlet weak var eventNameInput: UITextField!
	
	var event: Event?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if (segue.identifier == "SaveSegue") {
			event = Event(type: eventNameInput.text!)
		}
	}

}
