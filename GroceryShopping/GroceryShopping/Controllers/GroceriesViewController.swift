//
//  ViewController.swift
//  GroceryShopping
//
//  Created by Sismanidis, Evangelos (415) on 31.07.17.
//  Copyright © 2017 Private. All rights reserved.
//

import UIKit

class GroceriesViewController: UIViewController {

    private let tableView = UITableView()
    private var viewModel = GroceriesViewModel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = tableView
        self.title = "Grocery Shopping"
    }
}

extension GroceriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.groceriesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = GroceryTableViewCell()
        let grocery = viewModel.groceriesArray[indexPath.row]
        
        cell.textLabel?.text = grocery.name
        cell.amountLabel.text = String(describing: grocery.amount)
        cell.minusButton.addTarget(self, action: #selector(GroceriesViewController.minusButtonTapped(sender:)), for: .touchUpInside)
        cell.minusButton.tag = indexPath.row
        cell.addButton.addTarget(self, action: #selector(GroceriesViewController.addButtonTapped(sender:)), for: .touchUpInside)
        cell.addButton.tag = indexPath.row
        return cell
    }
}

extension GroceriesViewController {
    @objc func minusButtonTapped(sender: UIButton) {
        let newAmount = viewModel.groceriesArray[sender.tag].amount - 1
        viewModel.groceriesArray[sender.tag].amount = newAmount > 0 ? newAmount : 0
        self.tableView.reloadData()
    }
    
    @objc func addButtonTapped(sender: UIButton) {
        let newAmount = viewModel.groceriesArray[sender.tag].amount + 1
        viewModel.groceriesArray[sender.tag].amount = newAmount < 99 ? newAmount : 99
        self.tableView.reloadData()
    }
}

