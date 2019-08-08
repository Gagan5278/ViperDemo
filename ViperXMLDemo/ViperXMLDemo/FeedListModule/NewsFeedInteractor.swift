//
//  NewsFeedInteractor.swift
//  ViperXMLDemo
//
//  Created Gagan Vishal on 2019/08/07.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import UIKit

class NewsFeedInteractor: NewsFeedInteractorInputProtocol {
    var localDataManager: FeedListLocalDataManagerInputProtocol?
    var remoteDatamanager: FeedListRemoteDataManagerInputProtocol?
    weak var presenter: NewsFeedInteractorOutputProtocol?
    
    
    func fetchItems() {
//        presenter?.onRecieveItems()
//
//        if true {
//            localDataManager?.retrieveItems()
//            presenter?.onRecieveItems()
//        }
//        else {
            remoteDatamanager?.retriveFeedItems()
//        }
    }
}


extension NewsFeedInteractor:  FeedListRemoteDataManagerOutputProtocol {
    func onFeedRecieved(feedViewModel: [FeedViewModel]) {
        presenter?.onRecieveItems(feedViewModel: feedViewModel)
    }
    
    func onErrorRecieved(error: Error) {
        presenter?.onRecieveError(error: error)
    }
}
