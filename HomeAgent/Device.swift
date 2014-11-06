//
//  Device.swift
//  HomeAgent
//
//  Created by Peter Wikström on 06/11/14.
//  Copyright (c) 2014 Peter Wikström. All rights reserved.
//

import Foundation

typealias ActionResponse = (device:Device?, error:NSError?) -> Void

class Device {
    
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
    
    func toggle(completionHandler: ActionResponse){
        if (self.on) {
            call("off", completionHandler)
        } else {
            call("on", completionHandler)
        }
    }
    
    private func call(action: String, completionHandler: ActionResponse){
        
        let urlPath = "http://aepi.homeserver.com:8000/device/\(self.id)/\(action)"
        
        var request = NSMutableURLRequest(URL: NSURL(string: urlPath)!)
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "PUT"
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            self.on = action == "on" ? true : false
            completionHandler(device:self, error:nil)
        })
        
        task.resume()
        
    }
}

