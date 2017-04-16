//
//  UIImageTextField.swift
//  MetroMap
//
//  Created by Alex Vihlayew on 4/16/17.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

import UIKit

@IBDesignable class UIImageTextField: UITextField {

    let inset: CGFloat = 5
    
    @IBInspectable var image: UIImage? {
        didSet {
            updateView()
        }
    }
    @IBInspectable var imageColor: UIColor? {
        didSet {
            updateView()
        }
    }

    func updateView() {
        
        if let image = image {
            leftViewMode = .always
            leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: frame.height, height: frame.height))
            let imageView = UIImageView(frame: CGRect(x: inset, y: inset, width: frame.height - 2*inset, height: frame.height - 2*inset))
            imageView.image = image.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = imageColor
            leftView?.addSubview(imageView)
        }
        
    }
    
}
