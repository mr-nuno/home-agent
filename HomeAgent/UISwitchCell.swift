//
//  UISwitchCell.swift
//  HomeAgent
//
//  Created by Peter Wikström on 02/11/14.
//  Copyright (c) 2014 Peter Wikström. All rights reserved.
//

import UIKit

protocol ToggleSwitchDelegate {
    func toggleSwitch(string: String)
}

class UISwitchCell: UITableViewCell {

    @IBOutlet weak var deviceStatus: UISwitch!
    @IBOutlet weak var deviceName: UILabel!
    
    var delegate: ToggleSwitchDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(name: String, on: Bool){
        deviceName.text = name;
        deviceStatus.on = on;
    }
    
    @IBAction func toggleStatus(sender: UISwitch) {
        //delegate.selectUser("test");
        //even with just this println i get the error
        println(deviceStatus.on);
    }

}
