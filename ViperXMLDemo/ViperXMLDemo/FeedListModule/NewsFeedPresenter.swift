//
//  NewsFeedPresenter.swift
//  ViperXMLDemo
//
//  Created Gagan Vishal on 2019/08/07.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import UIKit

class NewsFeedPresenter  {
    weak private var view: NewsFeedViewProtocol?
    var interactor: NewsFeedInteractorInputProtocol?
    private let router: NewsFeedWireframeProtocol

    init(interface: NewsFeedViewProtocol, interactor: NewsFeedInteractorInputProtocol?, router: NewsFeedWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
}

extension NewsFeedPresenter: NewsFeedPresenterProtocol {
    func pushToViewController(feedProtocol: NewsFeedViewProtocol, segueName: String, feedModel: FeedViewModel) {
        self.router.pushToViewController(view: feedProtocol, segueName: segueName, viewModel: feedModel)
    }
    
    func viewDidLoaded() {
        view?.showHudView()
        interactor?.fetchItems()
    }
}

extension NewsFeedPresenter: NewsFeedInteractorOutputProtocol {
    func onRecieveItems(feedViewModel: [FeedViewModel]) {
        view?.didRecieveItem(feedViewModel: feedViewModel)
        view?.hideHudView()
    }
    
    func onRecieveError(error: Error) {
        view?.didRecieeveeError(error: error)
        view?.hideHudView()
    }
}
