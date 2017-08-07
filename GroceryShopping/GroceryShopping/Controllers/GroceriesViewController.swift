//
//  ViewController.swift
//  GroceryShopping
//
//  Created by Sismanidis, Evangelos on 31.07.17.
//  Copyright © 2017 Private. All rights reserved.
//

import UIKit

class GroceriesViewController: UIViewController {

    private let tableView = UITableView()
    private var viewModel = GroceriesViewModel()
    private var currenciesScrollView : VerticalScrollView
    
    init() {
        currenciesScrollView = VerticalScrollView(items: Array(viewModel.changeRates.keys))
        super.init(nibName: nil, bundle: nil)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView()
        view.addSubview(currenciesScrollView)
        currenciesScrollView.translatesAutoresizingMaskIntoConstraints = false
        currenciesScrollView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        currenciesScrollView.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant: 10).isActive = true
        currenciesScrollView.trailingAnchor.constraint(equalTo:view.trailingAnchor, constant: -10).isActive = true
        currenciesScrollView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        //segmentedControl.selectedSegmentIndex = 0
        
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: currenciesScrollView.bottomAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo:view.widthAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant: -20).isActive = true
        
        self.view = view
        self.title = viewModel.screenTitle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.updateRates(errorAction: {
            Alerts.showNetworkError(target: self)
        }, finishAction: {
            DispatchQueue.main.async {
                self.currenciesScrollView.setItems(items: Array(self.viewModel.changeRates.keys))
            }
        })
        
        let checkoutItem = UIBarButtonItem(image: #imageLiteral(resourceName: "logo_small"), style: .plain, target: self, action: #selector(checkout))
        self.navigationItem.rightBarButtonItem = checkoutItem
        
        let reloadCurrencyItem = UIBarButtonItem(image: #imageLiteral(resourceName: "download"), style: .plain, target: self, action: #selector(reloadCurrencies))
        self.navigationItem.leftBarButtonItem = reloadCurrencyItem
    }
}



extension GroceriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
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


// User Interaction
extension GroceriesViewController {
    @objc func minusButtonTapped(sender: UIButton) {
        viewModel.addToGroceryAtIndex(sender.tag, amount:-1)
        self.tableView.reloadData()
    }
    
    @objc func addButtonTapped(sender: UIButton) {
        viewModel.addToGroceryAtIndex(sender.tag, amount:+1)
        self.tableView.reloadData()
    }
    
    @objc func checkout() {
        let selectedCurrency = self.currenciesScrollView.selectedItem?.titleLabel?.text
        let totalAmount = viewModel.totalCosts(selectedCurrency!)
        Alerts.showTotalCosts(target: self, amount: totalAmount, currency: selectedCurrency!)
    }
    
    @objc func reloadCurrencies() {
        viewModel.updateRates(errorAction: {
            Alerts.showNetworkError(target: self)
        }) {
            
            DispatchQueue.main.async {
                self.currenciesScrollView.setItems(items: Array(self.viewModel.changeRates.keys))
                Alerts.succesfullUpdate(target: self)
            }
        }
    }
}

