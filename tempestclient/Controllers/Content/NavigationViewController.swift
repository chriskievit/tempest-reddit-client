//
// Created by Chris on 06/06/2020.
// Copyright (c) 2020 Tempest. All rights reserved.
//

import Foundation
import Cocoa

class NavigationViewController : NSViewController, NSOutlineViewDataSource, NSOutlineViewDelegate {
    @IBOutlet weak var outlineView: NSOutlineView!
    
    let viewModel = NavigationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.loadNavigationItems()
        outlineView.reloadData()
    }
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if item == nil {
          return viewModel.items.count
        } else if let navItem = item as? NavigationItem,
                  let children = navItem.children {
            return children.count
        }

        return 0
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if item == nil {
            return viewModel.items[index]
        } else if let navItem = item as? NavigationItem,
                  let children = navItem.children {
            return children[index]
        }

        return item
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        if let navItem = item as? NavigationItem,
            let children = navItem.children,
            !children.isEmpty {
            return true
        }

        return false
    }
    
    func outlineView(_ outlineView: NSOutlineView, objectValueFor tableColumn: NSTableColumn?, byItem item: Any?) -> Any? {
        return item
    }
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        var view: NSTableCellView?
        
        if let navItem = item as? NavigationItem {
            if !navItem.isHeader {
                view = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "DataCell"), owner: self) as? NSTableCellView

                if let textField = view?.textField,
                   let imageView = view?.imageView {
                    textField.stringValue = navItem.title
                    imageView.image = NSImage(named: NSImage.folderSmartName)
                }
            } else {
                view = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "HeaderCell"), owner: self) as? NSTableCellView

                if let textField = view?.textField {
                    textField.stringValue = navItem.title
                }
            }
        }
        
        return view
    }
}
