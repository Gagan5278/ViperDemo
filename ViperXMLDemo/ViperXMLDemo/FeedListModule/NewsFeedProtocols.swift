//
//  NewsFeedProtocols.swift
//  ViperXMLDemo
//
//  Created Gagan Vishal on 2019/08/07.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import Foundation

//MARK: Wireframe -
protocol NewsFeedWireframeProtocol: class {
    func pushToViewController(view: NewsFeedViewProtocol, segueName: String, viewModel: FeedViewModel)
}
//MARK: Presenter -
protocol NewsFeedPresenterProtocol: class {

    var interactor: NewsFeedInteractorInputProtocol? { get set }
    
    func viewDidLoaded()
    
    func pushToViewController(feedProtocol: NewsFeedViewProtocol, segueName: String, feedModel: FeedViewModel)
}

//MARK: Interactor -
protocol NewsFeedInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    func onRecieveItems(feedViewModel: [FeedViewModel])
    func onRecieveError(error: Error)
}

protocol NewsFeedInteractorInputProtocol: class {

    var presenter: NewsFeedInteractorOutputProtocol?  { get set }

    var localDataManager: FeedListLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: FeedListRemoteDataManagerInputProtocol? { get set }
    /* Presenter -> Interactor */
    func fetchItems()
}

//MARK: View -
protocol NewsFeedViewProtocol: class {

    var presenter: NewsFeedPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
    func showHudView()
    func hideHudView()
    func didRecieveItem(feedViewModel: [FeedViewModel])
    func didRecieeveeError(error: Error)
}

protocol FeedListRemoteDataManagerInputProtocol {
    var requestHandler: FeedListRemoteDataManagerOutputProtocol? {get set}
    
    func retriveFeedItems()
}


protocol FeedListRemoteDataManagerOutputProtocol {
    func onFeedRecieved(feedViewModel: [FeedViewModel])
    func onErrorRecieved(error: Error)
}


protocol FeedListLocalDataManagerInputProtocol {
    func retrieveItems()
    func saveItems()
}
