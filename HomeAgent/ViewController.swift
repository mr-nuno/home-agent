//
//  ViewController.swift
//  HomeAgent
//
//  Created by Peter Wikström on 01/11/14.
//  Copyright (c) 2014 Peter Wikström. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ToggleSwitchDelegate  {
    
    var tableData = [];
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getDevices()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UISwitchCell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as UISwitchCell
        
        var rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
        var name = rowData["name"] as String
        var on = rowData["on"] as Bool

        cell.setCell(name, on: on)
        
        return cell
    }
    
    func getDevices() {

        let urlPath = "http://aepi.homeserver.com:8000/device"
        let url = NSURL(string: urlPath)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            
            var err: NSError?
            
            self.tableData = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &err) as NSArray
            self.tableView!.reloadData()
        }
        
        task.resume()

    }
    
    func toggleSwitch(string: String){
    
    }
}

