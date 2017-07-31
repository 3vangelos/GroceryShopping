//
//  GroceryTableViewCell.swift
//  GroceryShopping
//
//  Created by Sismanidis, Evangelos (415) on 31.07.17.
//  Copyright © 2017 Private. All rights reserved.
//

import UIKit

class GroceryTableViewCell: UITableViewCell {

    let amountLabel = UILabel()
    var addButton = UIButton()
    var minusButton = UIButton(type: .custom)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        minusButton.setImage(#imageLiteral(resourceName: "minus"), for: .normal)
        self.addSubview(minusButton)
        minusButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        minusButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        minusButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.text = "0"
        self.contentView.addSubview(amountLabel)
        amountLabel.leadingAnchor.constraint(equalTo: self.minusButton.trailingAnchor).isActive = true
        amountLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true

        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        self.addSubview(addButton)
        addButton.leadingAnchor.constraint(equalTo: self.amountLabel.trailingAnchor).isActive = true
        addButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
