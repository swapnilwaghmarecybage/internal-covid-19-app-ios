//
//  HelplineViewController.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 8/25/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class HelplineViewController: UIViewController {

    @IBOutlet weak var tableViewHelpline: UITableView!
    private var headers = [String]()
    private var details = [String]()
    private var sectionStats = [Bool](repeating: true, count: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
       

        FirebaseManager.getHelplineData { (dictHelpline) in
            if let _dictHelpline = dictHelpline {
                self.headers = _dictHelpline.keys.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedDescending }
                for key in self.headers{
                    self.details.append( _dictHelpline[key] ?? "")
                }
                DispatchQueue.main.async {
                    self.sectionStats = [Bool](repeating: true, count: _dictHelpline.keys.count)
                    self.tableViewHelpline.reloadData()
                }
            }
        }
        
        tableViewHelpline.estimatedRowHeight = 50
        tableViewHelpline.rowHeight = UITableView.automaticDimension
        self.updateNavigationBar()

    }
    
    func updateNavigationBar(){
        self.navigationItem.title = "Helpline"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain , target: self, action: #selector(goBack))
        self.navigationItem.leftBarButtonItem?.tintColor = Theme.labelColor
        self.navigationItem.rightBarButtonItem = nil
    }

    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension HelplineViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard sectionStats[section] else {
            return 0
        }

        return 1
       // return details.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0: return headerView(section: 0, title: headers[0])
        case 1: return headerView(section: 1, title: headers[1])
        case 2: return headerView(section: 2, title: headers[2])
        default: return nil
        }
    }

private func headerView(section: Int, title: String) -> UIView {
    
    //let viewBg = UIView(frame: CGRect(x: 0, y: 0, width: self.tableViewHelpline.frame.width, height: 60))
    //let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableViewHelpline.frame.width, height: 60))
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.tableViewHelpline.frame.width - 30, height: 60))
    button.tag = section
    button.setTitle(title, for: .normal)
    button.setTitleColor(UIColor.white, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
    button.backgroundColor = Theme.highlightedColor
    button.contentHorizontalAlignment = .left
    let imageName = sectionStats[section] ? "downarrow" : "uparrow"
    button.setImage(UIImage(named: imageName), for: .normal)
    button.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.tableViewHelpline.frame.width - 70 , bottom: 0, right: 10)
    button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right:  0)
    button.tintColor = .white
    button.addTarget(self, action: #selector(sectionHeaderTapped), for: .touchUpInside)

    return button
}

     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    
@objc private func sectionHeaderTapped(sender: UIButton) {
    let section = sender.tag
    sectionStats[section] = !sectionStats[section]
    tableViewHelpline.beginUpdates()
    tableViewHelpline.reloadSections([section], with: .automatic)
    tableViewHelpline.endUpdates()
}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if let helplineCell = tableView.dequeueReusableCell(withIdentifier: "HelplineTableViewCell", for: indexPath) as? HelplineTableViewCell {
            helplineCell.configureCell(text: (details[indexPath.section]).replacingOccurrences(of: "\\n", with: "\n"))
            return helplineCell
        }
        return  UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }
    
        
}


extension HelplineViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
}
