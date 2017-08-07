//
//  UIScrollViewExtensions.swift
//  GroceryShopping
//
//  Created by Sismanidis, Evangelos on 07.08.17.
//  Copyright © 2017 Private. All rights reserved.
//

import UIKit

extension UIScrollView {
    func scrollToLeft() {
        let desiredOffset = CGPoint(x: -contentInset.left, y: 0)
        setContentOffset(desiredOffset, animated: true)
    }
}
