//
//  ViewController.swift
//  HomeAgent
//
//  Created by Peter Wikström on 01/11/14.
//  Copyright (c) 2014 Peter Wikström. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    let service = DeviceService()
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
        
        var device: Device = self.tableData[indexPath.row] as Device
        
        cell.setCell(device)
        
        return cell
    }
    
    func push(sender: UIDeviceSwitch){
        let a = sender.on ? "on" : "off"
        
        /*let urlPath = "http://aepi.homeserver.com:8000/device/\(sender.tag)/\(a)"
        
        var request = NSMutableURLRequest(URL: NSURL(string: urlPath)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "PUT"

        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
 
            var err: NSError?

            if(err != nil) {
               self.tableView!.reloadData()
            }
          
        })
        
        task.resume()*/
    }
    
    func getDevices() {
        DeviceService.sharedInstance.getDevices(){ (devices:[Device]?, error:NSError?) in
            self.tableData = devices!
            self.tableView!.reloadData()
        }
    }
}

