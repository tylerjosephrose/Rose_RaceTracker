//
//  MainViewController.swift
//  Rose_RaceTracker
//
//  Created by Tyler Rose on 4/6/17.
//  Copyright © 2017 Tyler Rose. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
	
	override func viewWillAppear(_ animated: Bool) {
		navigationController?.setToolbarHidden(true, animated: true)
		//navigationController?.setNavigationBarHidden(true, animated: true)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		//navigationController?.setNavigationBarHidden(false, animated: true)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
	
	@IBAction func cancel(import: UIStoryboardSegue) {
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func add(import: UIStoryboardSegue) {
		
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func replace(import: UIStoryboardSegue) {
		
		dismiss(animated: true, completion: nil)
	}

}
