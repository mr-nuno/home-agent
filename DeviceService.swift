//
//  DeviceService.swift
//  HomeAgent
//
//  Created by Peter Wikström on 03/11/14.
//  Copyright (c) 2014 Peter Wikström. All rights reserved.
//

import Foundation

typealias ActionResponse = (device:Device?, error:NSError?) -> Void

class Device{
    var id = 0
    var name = ""
    var on = false
    
    init(fromDevice id: Int, name: String, on: Bool){
        self.id = id
        self.name = name
        self.on = on
    }
    
    func turnOn(completionHandler: ActionResponse) {
        call("on", completionHandler)
    }
    
    func turnOff(completionHandler: ActionResponse) {
        call("off", completionHandler)
    }
    
    private func call(action: String, completionHandler: ActionResponse){
        
        let urlPath = "http://aepi.homeserver.com:8000/device/\(self.id)/\(action)"
        
        var request = NSMutableURLRequest(URL: NSURL(string: urlPath)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "PUT"
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            self.on = action == "on" ? true : false
            //completionHandler(device:self, error:nil)
        })
        
        task.resume()
        
    }
}

typealias ServiceResponse = (devices:[Device]?, error:NSError?) -> Void

class DeviceService {
    
    let url = "http://aepi.homeserver.com:8000/device"
    
    class var sharedInstance:DeviceService {
        struct Singleton {
            static let instance = DeviceService()
        }
        return Singleton.instance
    }
    
    func getDevices(completionHandler: ServiceResponse) {
    
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
            completionHandler(devices:deviceList, error:nil)
        })
        
        task.resume()
    }
}