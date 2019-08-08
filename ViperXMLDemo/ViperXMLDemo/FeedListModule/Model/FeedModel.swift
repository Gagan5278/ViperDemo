//
//  FeedModel.swift
//  XMLParser
//

import Foundation

struct FeedModel {
    let titleString: String
    let descriptionString : String
    let linkString: String
    let pubDateString: String
    let imageURLString: String
}

extension FeedModel {
    init?(json:Dictionary<String, AnyObject>) {
        guard let title = json["title"] as? String,
            let description = json["description"] as? String,
            let link = json["link"] as? String,
            let pubDate = json["pubDate"] as? String,
            let enclosure = json["enclosure"] as? String else {return nil}
        
        self.titleString = title
        self.descriptionString = description
        self.linkString = link
        self.pubDateString = pubDate
        self.imageURLString = enclosure
    }
}

