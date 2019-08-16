//
//  ApplicationContext.swift
//  macreddit
//
//  Created by Chris on 15/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation

class ApplicationContext {
    static let shared = ApplicationContext()
    
    let session: Session
    let deviceId: String = UUID().uuidString
    
    var currentSubreddit: Subreddit
    
    init() {
        session = Session()
        currentSubreddit = Subreddit(withName: "all", withId: "all")
        
        tryLoadPreviousState()
    }
    
    private func tryLoadPreviousState() { }
}
