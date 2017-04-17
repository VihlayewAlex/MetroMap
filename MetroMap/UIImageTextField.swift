//
//  UIImageTextField.swift
//  MetroMap
//
//  Created by Alex Vihlayew on 4/16/17.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

import UIKit

@IBDesignable class UIImageTextField: UITextField {

    @IBInspectable var inset: CGFloat = 8 {
        didSet {
            updateView()
        }
    }
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
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
    @IBInspectable var placeholderColor: UIColor? {
        didSet {
            updateView()
        }
    }
    @IBInspectable var rightButtonTitle: String = "" {
        didSet {
            updateView()
        }
    }
    @IBInspectable var rightButtonTitleSize: CGFloat = 16 {
        didSet {
            updateView()
        }
    }
    @IBInspectable var rightViewWidth: CGFloat? {
        didSet {
            updateView()
        }
    }
    @IBInspectable var rightViewColor: UIColor? {
        didSet {
            updateView()
        }
    }
    @IBInspectable var rightButtonColor: UIColor? {
        didSet {
            updateView()
        }
    }
    
    
    func updateView() {
        
        layer.cornerRadius = cornerRadius
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [NSForegroundColorAttributeName:placeholderColor ?? UIColor.black])
        
        if let image = image {
            leftViewMode = .always
            leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: frame.height, height: frame.height))
            let imageView = UIImageView(frame: CGRect(x: inset, y: inset, width: frame.height - 2*inset, height: frame.height - 2*inset))
            
            if imageColor != nil {
                imageView.image = image.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = imageColor
            } else {
                imageView.image = image
            }
            leftView?.addSubview(imageView)
        }
        
        rightViewMode = .always
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: rightViewWidth ?? 50.0, height: frame.height))
        rightButton.backgroundColor = rightViewColor
        rightButton.setTitle(rightButtonTitle, for: .normal)
        rightButton.setTitleColor(rightButtonColor, for: .normal)
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: rightButtonTitleSize)
        rightView = rightButton
        
    }
    
}
