//
//  BottomRouteView.swift
//  MetroMap
//
//  Created by Alex Vihlayew on 4/17/17.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

import UIKit

class BottomRouteView: UIView {

    @IBOutlet weak var startStationField: UIImageTextField!
    @IBOutlet weak var endStationField: UIImageTextField!
    

    
    @IBOutlet weak var effectView: UIVisualEffectView!
    var delegate: BottomRouteViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        effectView.layer.masksToBounds = false
        
        effectView.layer.shadowColor = UIColor.black.cgColor
        effectView.layer.shadowOpacity = 0.8
        effectView.layer.shadowRadius = 8
        effectView.layer.shadowOffset = CGSize.zero

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

protocol BottomRouteViewDelegate {
    
    func stationListButtonTapped(forField: UIImageTextField)
    func calculateWayButtonTapped()
    
}
