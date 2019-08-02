//
//  MainWindowController.swift
//  macreddit
//
//  Created by Chris on 02/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation
import Cocoa

class MainWindowController : NSWindowController {
    @IBAction func profileButtonClicked(sender: AnyObject) {
        let authWindowController: AuthWindowController = storyboard?.instantiateController(withIdentifier: "AuthWindowController") as! AuthWindowController
        
        authWindowController.showWindow(self)
    }
}
