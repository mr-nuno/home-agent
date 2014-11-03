//
//  UISwitchCell.swift
//  HomeAgent
//
//  Created by Peter Wikström on 02/11/14.
//  Copyright (c) 2014 Peter Wikström. All rights reserved.
//

import UIKit

class UISwitchCell: UITableViewCell {

    @IBOutlet weak var deviceStatus: UISwitch!
    @IBOutlet weak var deviceName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(name: String, on: Bool, id: String){
        deviceName.text = name
        deviceStatus.on = on
        deviceStatus.tag = id.toInt()!
    }
}
