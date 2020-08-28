//
//  FeedTableViewCell.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 8/13/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewInner: UIView!
    @IBOutlet weak var labelNewsTitle: UILabel!
    @IBOutlet weak var labelNewsContent: UILabel!
    @IBOutlet weak var labelNewsDate: UILabel!
    @IBOutlet weak var labelNewsSubject: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(newsModel: NewsModel) {
        self.viewInner.layer.cornerRadius = 10
        self.viewInner.backgroundColor = Theme.highlightedColor
        
        self.labelNewsDate.text =  Utilities.sharedInstance.getDateOfNews(timeStamp: newsModel.date, dateFormat: nil)
        self.labelNewsTitle.text = newsModel.title ?? ""
        self.labelNewsContent.text = newsModel.content ?? ""
        self.labelNewsSubject.text = newsModel.subject ?? ""
    }

}
