//
//  RadioButtonView.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 7/8/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import UIKit

class RadioButtonView: UIView {
    
    typealias didTapConfirmed = ((_ labels: [String], _ confirmed: [Double], _ color: UIColor, _ barName: String,_ barTag:Int) -> Void)
    typealias didTapActive = ((_ labels: [String], _ active: [Double], _ color: UIColor, _ barName: String,_ barTag:Int) -> Void)
    typealias didTapRecovered = ((_ labels: [String], _ recovered: [Double], _ color: UIColor, _ barName: String,_ barTag:Int) -> Void)
    typealias didTapDeceased = ((_ labels: [String], _ deceased: [Double], _ color: UIColor, _ barName: String,_ barTag:Int) -> Void)
    
    @IBOutlet fileprivate weak var btnConfirmed: UIButton!
    @IBOutlet fileprivate weak var btnActive: UIButton!
    @IBOutlet fileprivate weak var btnRecovered: UIButton!
    @IBOutlet fileprivate weak var btnDeceased: UIButton!
    
    fileprivate var barGraphDetails: BarGraphDataType!
    
    
    //    var delegate:closeCorouselDelegate?
    
    var showConfirmed: didTapConfirmed?
    {
        didSet
        {
            if showConfirmed != nil
            {
                self.btnConfirmed.addTarget(self, action: #selector(showConfirmedGraph), for: .touchUpInside)
            }
            else
            {
                self.btnConfirmed.removeTarget(self, action: #selector(showConfirmedGraph), for: .touchUpInside)
            }
        }
    }
    
    var showActive: didTapActive?
    {
        didSet
        {
            if showActive != nil
            {
                self.btnActive.addTarget(self, action: #selector(showActiveGraph), for: .touchUpInside)
            }
            else
            {
                self.btnActive.removeTarget(self, action: #selector(showActiveGraph), for: .touchUpInside)
            }
        }
    }
    
    var showRecovered: didTapRecovered?
    {
        didSet
        {
            if showRecovered != nil
            {
                self.btnRecovered.addTarget(self, action: #selector(showRecoveredGraph), for: .touchUpInside)
            }
            else
            {
                self.btnRecovered.removeTarget(self, action: #selector(showRecoveredGraph), for: .touchUpInside)
            }
        }
    }
    
    var showDeceased: didTapDeceased?
    {
        didSet
        {
            if showDeceased != nil
            {
                self.btnDeceased.addTarget(self, action: #selector(showDeceasedGraph), for: .touchUpInside)
            }
            else
            {
                self.btnDeceased.removeTarget(self, action: #selector(showDeceasedGraph), for: .touchUpInside)
            }
        }
    }
    
    
    //MARK: -
    
    //MARK: - View Methods
    internal func configure(_barGraphDetails:BarGraphDataType)
    {
        self.barGraphDetails = _barGraphDetails
        self.btnConfirmed.setImage(UIImage(named: "radiobuttonempty"), for: .normal)
        self.btnActive.setImage(UIImage(named: "radiobuttonempty"), for: .normal)
        self.btnRecovered.setImage(UIImage(named: "radiobuttonempty"), for: .normal)
        self.btnDeceased.setImage(UIImage(named: "radiobuttonempty"), for: .normal)
        
        self.btnConfirmed.setImage(UIImage(named: "radiobuttonfilled"), for: .selected)
        self.btnActive.setImage(UIImage(named: "radiobuttonfilled"), for: .selected)
        self.btnRecovered.setImage(UIImage(named: "radiobuttonfilled"), for: .selected)
        self.btnDeceased.setImage(UIImage(named: "radiobuttonfilled"), for: .selected)
        
        if UIScreen.main.bounds.width > 350 {
            self.btnConfirmed.titleLabel?.font = .systemFont(ofSize: 13)
            self.btnActive.titleLabel?.font = .systemFont(ofSize: 13)
            self.btnRecovered.titleLabel?.font = .systemFont(ofSize: 13)
            self.btnDeceased.titleLabel?.font = .systemFont(ofSize: 13)
        } else {
            self.btnConfirmed.titleLabel?.font = .systemFont(ofSize: 10)
            self.btnActive.titleLabel?.font = .systemFont(ofSize: 10)
            self.btnRecovered.titleLabel?.font = .systemFont(ofSize: 10)
            self.btnDeceased.titleLabel?.font = .systemFont(ofSize: 10)
        }
       

    }
    
    internal func showDefaultGraphofConfirmed(){
        if(self.btnConfirmed.isSelected == false
            && self.btnActive.isSelected == false
            && self.btnRecovered.isSelected == false
            && self.btnDeceased.isSelected == false ){
                self.showConfirmedGraph(sender: self.btnConfirmed)

        }
    }
    
    @objc fileprivate func showConfirmedGraph(sender: UIButton)
    {
        if let handler = showConfirmed
        {
            /*
            self.btnConfirmed.setImage(UIImage(named: "radiobuttonfilled"), for: .normal)
            self.btnActive.setImage(UIImage(named: "radiobuttonempty"), for: .normal)
            self.btnRecovered.setImage(UIImage(named: "radiobuttonempty"), for: .normal)
            self.btnDeceased.setImage(UIImage(named: "radiobuttonempty"), for: .normal)
             */
            self.btnConfirmed.isSelected = true
            self.btnActive.isSelected = false
            self.btnRecovered.isSelected = false
            self.btnDeceased.isSelected = false
            
            handler(self.barGraphDetails.0, self.barGraphDetails.1, BarColors.confirmedColor, BarName.confirmed.rawValue, BarTag.confirmed.rawValue)
        }
    }
    @objc fileprivate func showActiveGraph(sender: UIButton)
    {
        if let handler = showActive
        {
            /*
            self.btnConfirmed.setImage(UIImage(named: "radiobuttonempty"), for: .normal)
            self.btnActive.setImage(UIImage(named: "radiobuttonfilled"), for: .normal)
            self.btnRecovered.setImage(UIImage(named: "radiobuttonempty"), for: .normal)
            self.btnDeceased.setImage(UIImage(named: "radiobuttonempty"), for: .normal)
            */
            
            self.btnConfirmed.isSelected = false
            self.btnActive.isSelected = true
            self.btnRecovered.isSelected = false
            self.btnDeceased.isSelected = false
            handler(self.barGraphDetails.0, self.barGraphDetails.2, BarColors.activeColor, BarName.active.rawValue, BarTag.active.rawValue)
        }
    }
    @objc fileprivate func showRecoveredGraph(sender: UIButton)
    {
        if let handler = showRecovered
        {
            /*
            self.btnConfirmed.setImage(UIImage(named: "radiobuttonempty"), for: .normal)
            self.btnActive.setImage(UIImage(named: "radiobuttonempty"), for: .normal)
            self.btnRecovered.setImage(UIImage(named: "radiobuttonfilled"), for: .normal)
            self.btnDeceased.setImage(UIImage(named: "radiobuttonempty"), for: .normal)
 */
            self.btnConfirmed.isSelected = false
            self.btnActive.isSelected = false
            self.btnRecovered.isSelected = true
            self.btnDeceased.isSelected = false
            
            handler(self.barGraphDetails.0, self.barGraphDetails.3, BarColors.recoveredColor, BarName.receovered.rawValue, BarTag.receovered.rawValue)
        }
    }
    @objc fileprivate func showDeceasedGraph(sender: UIButton)
    {
        if let handler = showDeceased
        {
            /*
            self.btnConfirmed.setImage(UIImage(named: "radiobuttonempty"), for: .normal)
            self.btnActive.setImage(UIImage(named: "radiobuttonempty"), for: .normal)
            self.btnRecovered.setImage(UIImage(named: "radiobuttonempty"), for: .normal)
            self.btnDeceased.setImage(UIImage(named: "radiobuttonfilled"), for: .normal)
            */
            self.btnConfirmed.isSelected = false
            self.btnActive.isSelected = false
            self.btnRecovered.isSelected = false
            self.btnDeceased.isSelected = true
            
            handler(self.barGraphDetails.0, self.barGraphDetails.4, BarColors.deceasedColor, BarName.deceased.rawValue, BarTag.deceased.rawValue)
        }
    }
}
