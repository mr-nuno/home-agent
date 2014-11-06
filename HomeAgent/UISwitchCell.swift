//
//  UISwitchCell.swift
//  HomeAgent
//
//  Created by Peter Wikström on 02/11/14.
//  Copyright (c) 2014 Peter Wikström. All rights reserved.
//

import UIKit

class UISwitchCell: UITableViewCell {

    @IBOutlet weak var deviceStatus: UIDeviceSwitch!
    @IBOutlet weak var deviceName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCell(device: Device){
        deviceName.text = device.name
        deviceStatus.on = device.on
        deviceStatus.tag = device.id
        
        deviceStatus.device = device
        deviceStatus.addTarget(self, action: "push:", forControlEvents: UIControlEvents.AllTouchEvents)
    }
    
    func push(sender: UIDeviceSwitch){
        sender.device.toggle(){ (device: Device?, error: NSError?) in
            println("Device \(device?.id) is \(device?.on)")
        }
    }
}
