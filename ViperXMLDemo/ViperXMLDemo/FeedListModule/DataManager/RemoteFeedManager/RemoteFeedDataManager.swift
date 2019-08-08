//
//  RemoteFeedDataManager.swift
//  ViperXMLDemo
//
//  Created by Gagan Vishal on 2019/08/08.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation

class RemoteFeedDataManager: FeedListRemoteDataManagerInputProtocol {
    var requestHandler: FeedListRemoteDataManagerOutputProtocol?
    
    let kServiceUrl = "http://feeds.news24.com/articles/Fin24/Tech/rss"
    
    func retriveFeedItems() {
        URLSession.shared.dataTask(with: URL(string: kServiceUrl)!) {[weak self] data, response, error in
            guard let data = data, error == nil else {
                self?.requestHandler?.onErrorRecieved(error: error ?? NSError(domain: "COMMOM", code: 0, userInfo: nil))
                return
            }
            let xmlFormatter = XMLTransformer(data: data)
            if let feedItems = xmlFormatter.transform()
            {
                self?.requestHandler?.onFeedRecieved(feedViewModel: feedItems.map(FeedViewModel.init))
            }
            else{
                self?.requestHandler?.onErrorRecieved(error: error ?? NSError(domain: "COMMOM", code: 0, userInfo: nil))
            }
            }.resume()
    }
    
    
}
