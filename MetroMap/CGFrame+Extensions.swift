//
//  CGFrame+Extensions.swift
//  MetroMap
//
//  Created by Alex Vihlayew on 4/30/17.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

import UIKit

extension CGRect {

    func insetBy(top: CGFloat, right: CGFloat, bottom: CGFloat, left: CGFloat) -> CGRect {
        var newFrame = self.insetBy(dx: (left + right)/2, dy: (top + bottom)/2)
        newFrame.origin.x = left
        newFrame.origin.y = top
        return newFrame
    }

}
