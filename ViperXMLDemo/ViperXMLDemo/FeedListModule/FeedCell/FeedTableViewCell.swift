//
//  FeedTableViewCell.swift
//  ViperXMLDemo
//
//  Created by Gagan Vishal on 2019/08/07.
//  Copyright © 2019 Gagan Vishal. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
  //IBOutlets
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var feedDescriptionLabel: UILabel!
    // Var to handle image size
    internal var aspectConstraint : NSLayoutConstraint? {
        didSet {
            if oldValue != nil {
                feedImageView.removeConstraint(oldValue!)
            }
            if aspectConstraint != nil {
                aspectConstraint?.priority = UILayoutPriority(999)
                feedImageView.addConstraint(aspectConstraint!)
            }
        }
    }

    // URLSessionDataTask object to download user image
    var imageDownloadDataTask : URLSessionDataTask?
    // URL Session Object
    var urlSession = URLSession(configuration: .default)
    //MARK:- View life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK:- View Model Data
    var viewModel: FeedViewModel? {
        didSet{
            bindData()
        }
    }
    
    //MARK:- Bind data
    func bindData()
    {
        self.feedDescriptionLabel.attributedText = self.createAyttribuedString(from: viewModel?.newsFeedTitle, subTitleString: viewModel?.newFeedDetailString)
        self.downloadImageForMerchant(merchantImageURL: (viewModel?.newFeedImageURLString)!, forImageView: self.feedImageView)
    }

    //MARK:- Create an attributedString for title and description
    private func createAyttribuedString(from titleString: String?, subTitleString:String?) -> NSAttributedString {
        guard let title = titleString, let subTitle = subTitleString else
        {
            return NSAttributedString(string: "No details found for this news")
        }
        let titleAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.gray,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14.0)
        ]
        let descriptionAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.lightGray ,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12.0)
            ] as [NSAttributedString.Key : Any]
        
        let firstAttrString = NSAttributedString(string: title + "\n", attributes: titleAttributes)
        let secondAttrString = NSMutableAttributedString(string: subTitle, attributes: descriptionAttributes)
        let combination = NSMutableAttributedString()
        combination.append(firstAttrString)
        combination.append(secondAttrString)
        return combination
    }
    
    // MARK:- Async call of image download & save in NSCache with image url
    private func downloadImageForMerchant(merchantImageURL : String, forImageView imageView : UIImageView)
    {
        if merchantImageURL == "notFound"  //case when image not available
        {
            imageView.image = #imageLiteral(resourceName: "placeholder")
        }
        else{
            if imageDownloadDataTask != nil{
                imageDownloadDataTask?.cancel()
            }
            imageView.image = nil
            // Call service to download logo image from server
            imageDownloadDataTask  = self.urlSession.dataTask(with: URL(string: merchantImageURL as String)!, completionHandler: { (data, response, error) in
                if error != nil{
                    DispatchQueue.main.async {
                        imageView.image = #imageLiteral(resourceName: "placeHolder")  //placeHolder.png
                    }
                }
                else
                {
                    let response = response as! HTTPURLResponse
                    if response.statusCode == 200
                    {
                        if  let image = UIImage(data: data!)
                        {
                            DispatchQueue.main.async { [weak self] in
                                self?.setCustomImage(image: image)
                            }
                        }
                    }
                    else{
                        // Error
                        DispatchQueue.main.async {
                            imageView.image = #imageLiteral(resourceName: "placeHolder")  // Placeholder
                        }
                    }
                }
            })
            imageDownloadDataTask?.resume()
        }
    }

    //MARK:- Resize image as per size of cell
    private func setCustomImage(image : UIImage) {
        let aspect = image.size.width / image.size.height
        let constraint = NSLayoutConstraint(item: self.feedImageView!, attribute:.width, relatedBy: .equal, toItem: self.feedImageView, attribute: .height, multiplier: aspect, constant: 0.0)
        constraint.priority = UILayoutPriority(rawValue: 999)
        aspectConstraint = constraint
        self.feedImageView.image = image
    }
}
