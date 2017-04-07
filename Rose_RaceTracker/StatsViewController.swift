//
//  StatsViewController.swift
//  Rose_RaceTracker
//
//  Created by Tyler Rose on 4/6/17.
//  Copyright © 2017 Tyler Rose. All rights reserved.
//

import UIKit
import Charts

/*
	Charts is used based on the library given and created by Daniel Cohen Gindi & Philipp Jahoda
	The license can be found at http://www.apache.org/licenses/LICENSE-2.0
*/


class StatsViewController: UIViewController, ChartViewDelegate {

	@IBOutlet weak var lineChartView: LineChartView!
	@IBOutlet weak var prLbl: UILabel!
	@IBOutlet weak var sbLbl: UILabel!
	@IBOutlet weak var meetDetailsLbl: UILabel!
	
	var currentEvent: Event!
	private var timeStrings = [String]()
	private var dateStrings = [String]()
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		setupChart()
		setupLbls()
		lineChartView.delegate = self
    }
	
	private func setupLbls() {
		prLbl.text = "PR: " + Race.timeToString(time: currentEvent.getPR()!)
		sbLbl.text = ""
		var i = 0
		var sbs = [String]()
		for best in currentEvent.getSB() {
			sbs.append(String(best.key) + ": " + Race.timeToString(time: best.value) + "\n")
			i += 1
		}
		sbs.sort()
		var j = sbs.count
		for _ in 0..<sbs.count {
			j -= 1
			sbLbl.text?.append(sbs[j])
		}
		let index = sbLbl.text?.index(before: (sbLbl.text?.endIndex)!)
		sbLbl.text?.remove(at: index!)
		sbLbl.numberOfLines = i
	}
	
	private func setupChart() {
		lineChartView.delegate = self as ChartViewDelegate
		lineChartView.chartDescription?.text = ""
		lineChartView.noDataText = "No data provided"
		// Setup Data for chart
		var times = [TimeInterval]()
		var dates = [Date]()
		for race in currentEvent.getRaces() {
			times.append(race.getTime())
			dates.append(race.getDate())
		}
		
		// Y Axis data
		var yVals = [ChartDataEntry]()
		let dateFormatter = DateFormatter()
		dateFormatter.dateStyle = .short
		for i in 0 ..< dates.count {
			yVals.append(ChartDataEntry(x: Double(i), y: times[i]))
			timeStrings.append(Race.timeToString(time: times[i]))
			dateStrings.append(dateFormatter.string(from: dates[i]))
		}
		let ySet = LineChartDataSet(values: yVals, label: "Times")
		ySet.axisDependency = .left
		ySet.setColor(UIColor.red)
		ySet.setCircleColor(UIColor.red)
		ySet.lineWidth = 2.0
		ySet.circleRadius = 3.0
		ySet.valueFormatter = ElapsedTimeFormatter()
		
		var dataSets : [LineChartDataSet] = [LineChartDataSet]()
		dataSets.append(ySet)
		
		// Set data to graph
		let data = LineChartData(dataSets: dataSets)
		data.setValueTextColor(UIColor.red)
		
		lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dateStrings)
		lineChartView.xAxis.granularityEnabled = true
		lineChartView.xAxis.axisMaximum = Double(ySet.entryCount) - 0.9
		lineChartView.leftAxis.valueFormatter = ElapsedTimeAxisFormatter()
		lineChartView.leftAxis.inverted = true
		lineChartView.rightAxis.drawLabelsEnabled = false
		lineChartView.data = data
		lineChartView.animate(xAxisDuration: 1.0, easingOption: .easeInSine)
	}
	
	
	func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
		for race in currentEvent.getRaces() {
			let dateformatter = DateFormatter()
			dateformatter.dateStyle = .short
			if entry.y == race.getTime() && dateStrings[Int(entry.x)] == dateformatter.string(from: race.getDate()) {
				dateformatter.dateStyle = .medium
				meetDetailsLbl.text = ""
				meetDetailsLbl.text?.append(race.getLocation())
				meetDetailsLbl.text?.append("\n")
				meetDetailsLbl.text?.append(dateformatter.string(from: race.getDate()))
				meetDetailsLbl.text?.append("\n")
				meetDetailsLbl.text?.append(Race.timeToString(time: entry.y))
				meetDetailsLbl.text?.append("\n")
				meetDetailsLbl.text?.append(Race.placeToString(place: race.getPlace()!))
			}
		}
		//println("\(entry.value) in \(dateStrings[entry.xIndex])")
	}
	
	func chartValueNothingSelected(_ chartView: ChartViewBase) {
		meetDetailsLbl.text = ""
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
