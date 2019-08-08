//
//  RemoteDataManager.swift
//  ViperXMLDemo
//
//  Created by Gagan Vishal on 2019/08/08.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation
/*------------------- Uncomment below code if you want to load detail page from server------------------------*/
/*
class RemoteDataManager: WebViewInputProtocol {
    var webRequestHandler: FeedDetailInteractorProtocol?

    func requestWebViewContent(viewModel: FeedViewModel) {
        do {
            let htmlData = try Data(contentsOf: viewModel.newFeedDeialLink)
            webRequestHandler?.onSuccess(htmlData: htmlData)
        }
        catch {
            webRequestHandler?.onFailue(error: error)
        }
    }
}
*/
