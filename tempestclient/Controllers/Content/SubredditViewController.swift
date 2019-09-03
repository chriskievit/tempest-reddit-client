//
//  SubredditViewController.swift
//  tempestclient
//
//  Created by Chris on 16/08/2019.
//  Copyright © 2019 Tempest. All rights reserved.
//

import Foundation
import Cocoa

class SubredditViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    @IBOutlet weak var tableView: NSTableView!
    
    let viewModel: SubredditViewModel
    
    private enum CellIdentifiers {
        static let SubredditViewCell = "SubredditViewCell"
    }
    
    required init?(coder: NSCoder) {
        viewModel = SubredditViewModel(withSubreddit: ApplicationContext.shared.currentSubreddit)
        
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        if !ApplicationContext.shared.session.isAuthenticated() {
            ApplicationContext.shared.session.authenticate(code: nil) { (result: Result<Bool, RequestError>) in
                self.loadPosts()
            }
        } else {
            loadPosts()
        }
    }
    
    private func loadPosts() {
        viewModel.next { (result: Result<Bool, LoadingError>) in
            switch result {
            case .success(_):
                DispatchQueue.main.async{
                    let currentNumPosts = self.viewModel.numPosts
                    let batchSize = self.viewModel.batchSize
                    self.tableView.insertRows(at: IndexSet(integersIn: currentNumPosts-batchSize...currentNumPosts-1), withAnimation: .slideDown)
                }
                break
            case.failure(let error):
                print(error)
            }
        }
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return viewModel.numPosts
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let post: Post? = viewModel.getPostAtIndex(index: row)
        
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: CellIdentifiers.SubredditViewCell), owner: nil) as? SubredditCell,
            let post = post {
            cell.textField?.stringValue = post.title
            cell.subredditLabel.stringValue = post.subreddit
            cell.commentsLabel.stringValue = "\(post.numComments)"
            cell.scoreLabel.stringValue = "\(post.score)"
            cell.nsfwLabel.isHidden = !post.nsfw
            
            if let thumbnail = post.thumbnail {
                var image = NSImage(named: NSImage.touchBarTextCenterAlignTemplateName)
                if thumbnail.starts(with: "https"), let thumbUrl = URL(string: thumbnail) {
                    image = NSImage(byReferencing: thumbUrl)
                }
                
                // Set rounded corner
                cell.previewImageView.wantsLayer = true
                cell.previewImageView.layer?.cornerRadius = 8.0
                cell.previewImageView.layer?.masksToBounds = true
                
                cell.previewImageView.image = image
            }
            
            return cell
        }
        
        return nil
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        if row == viewModel.numPosts - 5, !viewModel.isLoading {
            self.loadPosts()
        }
        
        return nil
    }
}
