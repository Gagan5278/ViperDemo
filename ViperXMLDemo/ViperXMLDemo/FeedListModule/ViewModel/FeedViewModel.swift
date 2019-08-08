//
//  FeedViewModel.swift
//  ViperXMLDemo
/*  Note: Here you can perform data manipulation before u send it to Presener */
//  Created by Gagan Vishal on 2019/08/08.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation

struct FeedViewModel {
    let newsFeedTitle: String
    let newFeedDetailString: String
    let newFeedDeialLink : URL
    let newsFeedPublishDate: String
    let newFeedImageURLString: String
}

extension FeedViewModel {
    init(feedItem: FeedModel) {
        self.newsFeedTitle = feedItem.titleString
        self.newFeedDetailString = feedItem.descriptionString
        self.newFeedDeialLink = URL(string: feedItem.linkString) ?? URL(string: " ")!
        self.newsFeedPublishDate = feedItem.pubDateString
        self.newFeedImageURLString = feedItem.imageURLString
    }
}
