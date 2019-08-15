//
//  AccountsViewController.swift
//  macreddit
//
//  Created by Chris on 15/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation
import Cocoa

class AccountsViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    @IBOutlet weak var tableView: NSTableView!
    
    @IBAction func closeButtonPressed(_ sender: NSButton) {
        if presentingViewController == nil {
            view.window?.close()
        } else {
            dismiss(self)
        }
    }
    
    @IBAction func addButtonPressed(_ sender: NSButton) {
    }
    
    @IBAction func removeButtonPressed(_ sender: NSButton) {
    }
}
