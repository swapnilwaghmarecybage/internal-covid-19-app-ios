//
//  FeedDetailViewController.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 8/13/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class FeedDetailViewController: UIViewController {
    
    @IBOutlet weak var feedTextView: UITextView!
    var news: NewsModel?
    var newsid: String?
    
    // @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateNavigationBar()
        
        if let _ = self.news {
            self.updateView()
        } else if let  _newsId = self.newsid {
            FirebaseManager.getNewsForId(newsId: _newsId) { (_news) in
                self.news = _news
                self.updateView()
            }
        } else {
            print("No news ID no news")
        }
    }
    
    func updateNavigationBar(){
        self.navigationItem.title = "Feed Details"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain , target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem?.tintColor = Theme.labelColor
        self.navigationItem.rightBarButtonItem = nil
    }
    
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func updateView(){
        
        let titleAtributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular) ]
        let subjectAtributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.backgroundColor: Theme.selfAssistanceLightPeacockColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: .bold) ]
        let dateAttributes =  [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .regular)]
        let detailsAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular)]
        let linkAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .regular)]
        
        let detailsString = news?.content ?? ""
        
        let title = NSMutableAttributedString(string: news?.title ?? "", attributes: titleAtributes)
        let subject = NSMutableAttributedString(string: "\(news?.subject ?? "")\n", attributes: subjectAtributes)
        let date = NSMutableAttributedString(string: "\n\(Utilities.sharedInstance.getDateOfNews(timeStamp: news?.date, dateFormat: "MMM dd YYYY hh:mm a") )\n\n", attributes: dateAttributes)
        let receivedLink = news?.link ?? "https://www.cybage.com/"
        let link = NSMutableAttributedString(string: "\n\nLink: \(receivedLink)", attributes: linkAttributes)
        link.addAttribute(.link, value: receivedLink, range: NSRange(location: 7, length: receivedLink.count + 1))
        
        let details = NSMutableAttributedString(string: "\n\n\(detailsString)", attributes: detailsAttributes)
        let combination = NSMutableAttributedString()
        
        combination.append(subject)
        combination.append(title)
        combination.append(date)
        combination.append(link)
        combination.append(details)
        
        self.feedTextView.attributedText = combination
        
        if let urlString = news?.getPhotoUrl(), let url = URL(string: urlString) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            let attachment = NSTextAttachment()
                                   let imageView = UIImageView()
                                   imageView.image = image
                                   guard let imgSize = imageView.image?.size else {
                                       fatalError("Could not get size of image!")
                                   }
                                let newWidth = (self?.feedTextView.frame.width ?? 0) - 50
                                   let scale = newWidth / imgSize.width
                                   let newHeight = imgSize.height * scale
                                   
                                   attachment.bounds = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
                                   attachment.image = imageView.image
                                   let attachmentString = NSAttributedString(attachment: attachment)
                            combination.replaceCharacters(in: NSMakeRange(title.length + subject.length + date.length, 0), with: attachmentString)
                            self?.feedTextView.attributedText = combination
                        }
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // textViewHeight.constant = feedTextView.sizeThatFits(CGSize(width: feedTextView.frame.size.width, height: CGFloat.greatestFiniteMagnitude)).height
    }
    
    func appendImage(){
        
    }
}

extension FeedDetailViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return true
    }
}

