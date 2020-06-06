//
// Created by Chris on 06/06/2020.
// Copyright (c) 2020 Tempest. All rights reserved.
//

import Foundation
import Cocoa

class NavigationViewController : NSViewController, NSOutlineViewDataSource, NSOutlineViewDelegate {
    @IBOutlet weak var outlineView: NSOutlineView!
    
    let items: [String] = ["Home", "Popular Posts", "All Posts"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        return items.count
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        return items[index]
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        return false
    }
    
    func outlineView(_ outlineView: NSOutlineView, objectValueFor tableColumn: NSTableColumn?, byItem item: Any?) -> Any? {
        return item
    }
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        var view: NSTableCellView?
        
        if let title = item as? String {
            view = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "DataCell"), owner: self) as? NSTableCellView
            
            if let textField = view?.textField,
                let imageView = view?.imageView {
                textField.stringValue = title
                imageView.image = NSImage(named: NSImage.folderSmartName)
            }
        }
        
        return view
    }
}
