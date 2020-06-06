//
// Created by Chris on 06/06/2020.
// Copyright (c) 2020 Tempest. All rights reserved.
//

import Foundation

class NavigationViewModel {
    var items: [NavigationItem] = []

    func loadNavigationItems() {
        items.append(contentsOf: [
            NavigationItem(withTitle: "Home", andChildren: nil, isHeader: false),
            NavigationItem(withTitle: "Popular Posts", andChildren: nil, isHeader: false),
            NavigationItem(withTitle: "All Posts", andChildren: nil, isHeader: false),
            NavigationItem(withTitle: "Multireddits", andChildren: nil, isHeader: true),
            NavigationItem(withTitle: "My Subreddits", andChildren: nil, isHeader: true)
        ])
    }
}

class NavigationItem {
    let title: String
    let children: [NavigationItem]?
    let isHeader: Bool

    init(withTitle title: String, andChildren children: [NavigationItem]?, isHeader header: Bool) {
        self.title = title
        self.children = children
        self.isHeader = header
    }
}
