//
//  RaceTableViewController.swift
//  Rose_RaceTracker
//
//  Created by Tyler Rose on 4/5/17.
//  Copyright © 2017 Tyler Rose. All rights reserved.
//

import UIKit

class RaceTableViewController: UITableViewController {
	
	var event: Event!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		self.navigationItem.leftItemsSupplementBackButton = true
		self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func viewWillAppear(_ animated: Bool) {
		navigationController?.setToolbarHidden(false, animated: true)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		navigationController?.setToolbarHidden(true, animated: true)
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return event.getCountOfRaces()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RaceCell", for: indexPath) as! DateTableViewCell
		
		var i = 0
		for race in event.getRaces() {
			if i == indexPath.row {
				print(Race.timeToString(time: race.getTime()))
				cell.timeLbl.text = Race.timeToString(time: race.getTime())
				cell.meetLbl.text = race.getLocation()
				if race.getPlace() != nil {
					cell.eventLbl.text = Race.placeToString(place: race.getPlace()!)
				} else {
					cell.eventLbl.text = ""
				}
			}
			i += 1
		}

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
			event.removeRace(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
		if segue.identifier == "NewRace" {
			let navVC = segue.destination as! UINavigationController
			let destination = navVC.viewControllers.first as! NewRaceViewController
			destination.currentEvent = event
		}
    }
	
	@IBAction func save(race segue: UIStoryboardSegue) {
		//let source = segue.source as! NewRaceViewController
		//let newRace = source.event
		//Person.getInstance().addEvent(event: newEvent!)
		tableView.reloadData()
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func cancel(race segue: UIStoryboardSegue) {
		navigationController?.setToolbarHidden(false, animated: true)
		dismiss(animated: true, completion: nil)
	}
}
