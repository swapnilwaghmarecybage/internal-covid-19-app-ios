//
//  FeedListViewController.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 8/13/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class FeedListViewController: UIViewController {
    @IBOutlet weak var feedsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseManager.delegateFeedsResponce = self
        FirebaseManager.fetchAllNewsFromFirebase()
        self.updateNavigationBar()
    }
    
    func updateNavigationBar(){
        self.navigationItem.title = "Feeds"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain , target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem?.tintColor = Theme.labelColor
        self.navigationItem.rightBarButtonItem = nil
    }
    
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension FeedListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FirebaseManager.arrayNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let feedCell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as? FeedTableViewCell {
            feedCell.configureCell(newsModel: FirebaseManager.arrayNews[indexPath.row])
            return feedCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            feedsTableView.beginUpdates()
            DBManager.save(id:FirebaseManager.arrayNews[indexPath.row].id)
            FirebaseManager.arrayNews.remove(at: indexPath.row)
            feedsTableView.deleteRows(at: [indexPath], with: .automatic)
            feedsTableView.endUpdates()
        }
    }
}

extension FeedListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if let feedDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "FeedDetailViewController") as? FeedDetailViewController{
            feedDetailVC.news = FirebaseManager.arrayNews[indexPath.row]
            self.navigationController?.pushViewController(feedDetailVC, animated: true)
        }
    }
}

extension FeedListViewController : FirebaseFeedResponse {
    func feedsReceivedSuccess() {
        self.feedsTableView.reloadData()
    }
}
