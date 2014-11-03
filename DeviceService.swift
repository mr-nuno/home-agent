//
//  DeviceService.swift
//  HomeAgent
//
//  Created by Peter Wikström on 03/11/14.
//  Copyright (c) 2014 Peter Wikström. All rights reserved.
//

import Foundation

class Device{
    var id = 0
    var name = ""
    var on = false
    
    init(fromDevice id: Int, name: String, on: Bool){
        self.id = id
        self.name = name
        self.on = on
    }
    
    func turnOn(callBack: (device: Device) -> ()) {
        call("on", callBack)
    }
    
    func turnOff(callBack: (device: Device) -> ()) {
        call("off", callBack)
    }
    
    private func call(action: String, callBack: (device: Device) -> ()){
        
        let urlPath = "http://aepi.homeserver.com:8000/device/\(self.id)/\(action)"
        
        var request = NSMutableURLRequest(URL: NSURL(string: urlPath)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "PUT"
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            self.on = action == "on" ? true : false
            callBack(device: self)
        })
        
        task.resume()
        
    }
}

class DeviceService {
    
    let url = "http://aepi.homeserver.com:8000/device"
    
    func getDevices(completionHandler: (devices: [Device]) -> ()) {
    
        var request = NSMutableURLRequest(URL: NSURL(string:self.url)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        
        var deviceList: [Device] = [Device]()
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            var err: NSError?
            var json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &err) as NSArray
            
            for row in json{
            
                var rowData: NSDictionary = row as NSDictionary
                
                var name = rowData["name"] as String
                var on = rowData["on"] as Bool
                var id = rowData["id"] as String
                
                deviceList.append(Device(fromDevice: id.toInt()!, name: name, on: on))
            
            }
            
            //notify changes
            completionHandler(devices: deviceList)
        })
        
        task.resume()
    }
}