//
//  EventTableViewController.swift
//  Rose_RaceTracker
//
//  Created by Tyler Rose on 4/4/17.
//  Copyright © 2017 Tyler Rose. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController {
	
	private var person: Person?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
		self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationItem.leftBarButtonItem = self.editButtonItem
		person = Person.getInstance()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (person?.getCountOfEvents())!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
		let events = person?.getEvents()
		cell.textLabel?.text = events?[indexPath.row].getType()
		if events?[indexPath.row].getPR() != nil {
			cell.detailTextLabel?.text = Race.timeToString(time: (events?[indexPath.row].getPR())!)
		} else {
			cell.detailTextLabel?.text = ""
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
			if (person?.getEvents()[indexPath.row].getCountOfRaces())! > 0 {
				let alert = UIAlertController()
				alert.title = "Are you sure you want to delete?"
				alert.message = "This event has races stored within it"
				let okay = UIAlertAction(title: "Continue", style: .default, handler: { (action: UIAlertAction!) in
					self.person?.removeEvent(atIndex: indexPath.row)
					tableView.deleteRows(at: [indexPath], with: .fade)
				})
				let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
				alert.addAction(okay)
				alert.addAction(cancel)
				present(alert, animated: true, completion: nil)
			} else {
				person?.removeEvent(atIndex: indexPath.row)
				tableView.deleteRows(at: [indexPath], with: .fade)
			}
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	
	@IBAction func cancel(segue: UIStoryboardSegue) {
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func save(segue: UIStoryboardSegue) {
		let source = segue.source as! NewEventViewController
		let newEvent = source.event
		Person.getInstance().addEvent(event: newEvent!)
		tableView.reloadData()
		dismiss(animated: true, completion: nil)
	}

}
