//
//  VerticalScrollView.swift
//  GroceryShopping
//
//  Created by Sismanidis, Evangelos on 07.08.17.
//  Copyright © 2017 Private. All rights reserved.
//

import UIKit

class VerticalScrollView: UIScrollView {
    
    public var selectedItem: UIButton? = nil
    private var buttons: [UIButton] = [UIButton]()
    
    init(items: [String]) {
        super.init(frame: CGRect.null)
        self.setItems(items: items)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setItems(items: [String]) {
        self.loadButtons(items: items)
        var leftView : UIView = self
        for button in self.buttons {
            button.translatesAutoresizingMaskIntoConstraints = false
            if leftView == self {
                button.leadingAnchor.constraint(equalTo:leftView.leadingAnchor, constant: 10).isActive = true
            } else {
                button.leadingAnchor.constraint(equalTo:leftView.trailingAnchor, constant: 10).isActive = true
            }
            if button == self.buttons.last {
                button.trailingAnchor.constraint(equalTo:self.trailingAnchor, constant: -10).isActive = true
            }
            button.centerYAnchor.constraint(equalTo:self.centerYAnchor).isActive = true
            button.heightAnchor.constraint(equalTo:self.heightAnchor).isActive = true
            leftView = button
        }
        self.scrollToLeft()
    }
}

// Private Helpers
extension VerticalScrollView {
    private func loadButtons(items: [String]) {
        self.resetView()
        for item in items {
            self.addButtonForCurrency(item)
        }
        self.setItemSelected(button: self.buttons.first!)
    }

    private func addButtonForCurrency(_ currency: String) {
        let button = UIButton(type: .system)
        button.setTitle(currency, for: .normal)
        button.addTarget(self, action: #selector(selectCurrency(sender:)), for: .touchUpInside)
        self.addSubview(button)
        if currency != "USD" {
            self.buttons.append(button)
        } else {
            self.buttons.insert(button, at: 0)
        }
    }
    
    private func resetView() {
        for button in self.buttons {
            button.removeFromSuperview()
        }
    
        self.buttons = [UIButton]()
    }
    
    @objc private func selectCurrency(sender: UIButton) {
        self.setItemSelected(button: sender)
    }
    
    private func setItemSelected(button: UIButton) {
        self.selectedItem?.isSelected = false
        self.selectedItem = button
        self.selectedItem?.isSelected = true
    }
}
