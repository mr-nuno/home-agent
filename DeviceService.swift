//
//  DeviceService.swift
//  HomeAgent
//
//  Created by Peter Wikström on 03/11/14.
//  Copyright (c) 2014 Peter Wikström. All rights reserved.
//
import Foundation

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
                
                if(id == "3"){
                    name = "Motorvärmare"
                    deviceList.append(Device(fromDevice: id.toInt()!, name: name, on: on))
                }
                
                if(id == "6"){
                    name = "Vardagsrum"
                    deviceList.append(Device(fromDevice: id.toInt()!, name: name, on: on))
                }
                
                if(id == "7"){
                    name = "Hall"
                    deviceList.append(Device(fromDevice: id.toInt()!, name: name, on: on))
                }
                
                if(id == "8"){
                    name = "Hobbyrum"
                    deviceList.append(Device(fromDevice: id.toInt()!, name: name, on: on))
                }
            }
            
            //notify changes
            completionHandler(devices:deviceList, error:nil)
        })
        
        task.resume()
    }
}