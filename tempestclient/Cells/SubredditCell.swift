//
//  SubredditCell.swift
//  tempestclient
//
//  Created by Chris on 23/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation
import Cocoa

class SubredditCell: NSTableCellView {
    @IBOutlet weak var previewImageView: NSImageView!
    @IBOutlet weak var subredditLabel: NSTextField!
    @IBOutlet weak var scoreLabel: NSTextField!
    @IBOutlet weak var commentsLabel: NSTextField!
    @IBOutlet weak var timeLabel: NSTextField!
    @IBOutlet weak var nsfwLabel: NSTextField!
}
