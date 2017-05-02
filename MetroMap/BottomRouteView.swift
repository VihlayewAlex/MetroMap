//
//  BottomRouteView.swift
//  MetroMap
//
//  Created by Alex Vihlayew on 4/17/17.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

import UIKit

class BottomRouteView: UIView {
    
    @IBOutlet weak var startView: UIView!
    @IBOutlet weak var endView: UIView!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var endLabel: UILabel!
    
    @IBOutlet weak var view: UIView!
    var delegate: BottomRouteViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Adding shadow image
        self.clipsToBounds = false
        
        let shadowImage = UIImage(named: "shadow")
        let insets = UIEdgeInsets(top: 35, left: 35, bottom: 35, right: 35)
        let resizableImage = shadowImage?.resizableImage(withCapInsets: insets)
        let shadowFrame = CGRect(x: -14, y: -11, width: self.frame.width + 28, height: self.frame.height + 22)
        let shadowImageView = UIImageView(frame: shadowFrame)
        shadowImageView.image = resizableImage
        self.insertSubview(shadowImageView, at: 0)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        
    }
    
    
    
    // Touches handling
    @IBAction func firstButtonTouchDown(_ sender: UIButton) {
        startView.backgroundColor = UIColor(red:0.38, green:0.38, blue:0.38, alpha:0.35)
    }
    
    @IBAction func secondButtonTouchDown(_ sender: UIButton) {
        endView.backgroundColor = UIColor(red:0.38, green:0.38, blue:0.38, alpha:0.35)
    }
    
    @IBAction func firstButtonTouchUpOutside(_ sender: UIButton) {
        startView.backgroundColor = UIColor(red:0.38, green:0.38, blue:0.38, alpha:0.27)
    }
    
    @IBAction func secondButtonTouchUpOutside(_ sender: UIButton) {
        endView.backgroundColor = UIColor(red:0.38, green:0.38, blue:0.38, alpha:0.27)
    }
    
    
    @IBAction func firstButtonTouchUpInside(_ sender: UIButton) {
        startView.backgroundColor = UIColor(red:0.38, green:0.38, blue:0.38, alpha:0.27)
        delegate?.startButtonDidTouched()
    }
    
    @IBAction func secondButtonTouchUpInside(_ sender: UIButton) {
        endView.backgroundColor = UIColor(red:0.38, green:0.38, blue:0.38, alpha:0.27)
        delegate?.endButtonDidTouched()
    }


    @IBAction func calculateButtonTapped(_ sender: Any) {
        delegate?.calculateWayButtonTapped()
    }

    
    
}

protocol BottomRouteViewDelegate {
    
    func startButtonDidTouched()
    func endButtonDidTouched()
    func calculateWayButtonTapped()
    
}
