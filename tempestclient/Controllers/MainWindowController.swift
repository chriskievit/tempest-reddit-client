//
//  MainWindowController.swift
//  tempestclient
//
//  Created by Chris on 02/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation
import Cocoa

class MainWindowController : NSWindowController {
    @IBAction func profileButtonClicked(sender: AnyObject) {
        let accountController: NSWindowController = storyboard?.instantiateController(withIdentifier: "AccountWindowController") as! NSWindowController
        window?.beginSheet(accountController.window!, completionHandler: nil)
    }
}
