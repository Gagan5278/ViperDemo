//
//  NewsFeedViewController.swift
//  ViperXMLDemo
//
//  Created Gagan Vishal on 2019/08/07.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController  {
    //IBOutlets
    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    //var to store all feeds
    var allNewsFeedArray = [FeedViewModel]()
	var presenter: NewsFeedPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoaded()
    }

}

//MARK:- NewsFeedViewProtocol
extension NewsFeedViewController: NewsFeedViewProtocol {
    func didRecieveItem(feedViewModel: [FeedViewModel]) {
        self.allNewsFeedArray = feedViewModel
        DispatchQueue.main.async { [weak self] in
            self?.feedTableView.reloadData()
        }
    }
    
    func didRecieeveeError(error: Error) {
        
    }
    
    func showHudView() {
        self.activityIndicator.startAnimating()
    }
    
    func hideHudView() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
    }
}

//MARK:- UITableeViewDelegates
extension NewsFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemFeed = self.allNewsFeedArray[indexPath.row]
        presenter?.pushToViewController(feedProtocol: self, segueName: "showDetail",feedModel:itemFeed)
    }
}

//MARK:- UITableViewDataSource
extension NewsFeedViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allNewsFeedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell
        cell.viewModel = self.allNewsFeedArray[indexPath.row]
        return cell
    }
    
}
