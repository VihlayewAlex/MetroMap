//
//  UIImage+Extensions.swift
//  MetroMap
//
//  Created by Alex Vihlayew on 5/9/17.
//  Copyright © 2017 Alex Vihlayew. All rights reserved.
//

import Foundation

extension UIImage {

    convenience init(withLineName name: String) {
        self.init(named: name + "dot")!
    }

}
