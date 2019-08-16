//
//  SubredditViewController.swift
//  macreddit
//
//  Created by Chris on 16/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation
import Cocoa

class SubredditViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    let viewModel: SubredditViewModel
    
    required init?(coder: NSCoder) {
        viewModel = SubredditViewModel(withSubreddit: ApplicationContext.shared.currentSubreddit)
        
        super.init(coder: coder)
    }
}
