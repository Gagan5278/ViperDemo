//
//  NewsFeedRouter.swift
//  ViperXMLDemo
//
//  Created Gagan Vishal on 2019/08/07.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import UIKit

class NewsFeedRouter: NewsFeedWireframeProtocol {
    
    weak var viewController: UIViewController?
    
    static func createFeedListModule() -> UIViewController {
        let navController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "RootNavController")
        if  let view = navController.children.first as?   NewsFeedViewController
        {
            let interactor: NewsFeedInteractorInputProtocol & FeedListRemoteDataManagerOutputProtocol = NewsFeedInteractor()
            let router = NewsFeedRouter()
            let presenter = NewsFeedPresenter(interface: view, interactor: interactor, router: router)
            
            interactor.localDataManager  =  LocalFeedDataManager()
            
            var remoteDataManager: FeedListRemoteDataManagerInputProtocol = RemoteFeedDataManager()
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.requestHandler = interactor
            
            view.presenter = presenter
            interactor.presenter = presenter
            router.viewController = view
            return navController
        }
        return UIViewController()
    }
    
    //MARK:- Push to detailView Controller
    func pushToViewController(view: NewsFeedViewProtocol, segueName: String, viewModel: FeedViewModel) {
        let detailViewController = FeedDetailRouter.createFeedDetailModule(viewModel: viewModel)
        if let superView = view as? UIViewController {
            superView.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}
