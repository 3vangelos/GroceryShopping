//
//  GroceryTableViewCell.swift
//  GroceryShopping
//
//  Created by Sismanidis, Evangelos on 31.07.17.
//  Copyright © 2017 Private. All rights reserved.
//

import UIKit

class GroceryTableViewCell: UITableViewCell {

    let amountLabel = UILabel()
    var addButton = UIButton()
    var minusButton = UIButton(type: .custom)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let SIZE : CGFloat = 30
        let MARGIN : CGFloat = 17
        
        addButton.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(addButton)
        addButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -MARGIN).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: SIZE).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: SIZE).isActive = true
       
        amountLabel.text = "0"
        amountLabel.textAlignment = .center
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(amountLabel)
        amountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        amountLabel.trailingAnchor.constraint(equalTo: self.addButton.leadingAnchor, constant: -MARGIN).isActive = true
        amountLabel.widthAnchor.constraint(equalToConstant: SIZE).isActive = true
        amountLabel.heightAnchor.constraint(equalToConstant: SIZE).isActive = true
        
        minusButton.setImage(#imageLiteral(resourceName: "minus"), for: .normal)
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(minusButton)
        minusButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        minusButton.trailingAnchor.constraint(equalTo: self.amountLabel.leadingAnchor, constant: -MARGIN).isActive = true
        minusButton.widthAnchor.constraint(equalToConstant: SIZE).isActive = true
        minusButton.heightAnchor.constraint(equalToConstant: SIZE).isActive = true
        
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = Colors.blue
        self.addSubview(separator)
        separator.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: MARGIN).isActive = true
        separator.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
