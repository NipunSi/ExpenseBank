//
//  ViewController.swift
//  TBInterview
//
//  Created by Zachary Rhodes on 5/25/21.
//

import UIKit

class ViewController: UIViewController {
    let interactor = Interactor(api: API())
    
    let tableView = UITableView()
    let monthLabel = UILabel()
    let categoryLabel = UILabel()
    let amountSpentLabel = UILabel()

    var expenses: [Expense] = [Expense]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Setup notification observer to reload UI when new expense data is available
        NotificationCenter.default.addObserver(self, selector: #selector(reloadUI), name: NSNotification.Name(rawValue: "load"), object: nil)

        //Setup initial UI and get the first expense data
        getExpenses()
        configureTableView()
        configureLabels()
    }
    
    private func getExpenses() {
        interactor.getExpenses()
        expenses = interactor.expenses
    }

    private func fillUI() {
        //Add category (name & emoji) with most spend to categoryLabel
        categoryLabel.text = interactor.mostSpentCategory
        
        //Add total monthly spend to amountSpentLabel (with proper coloring)
        amountSpentLabel.text = String(format: "$%.2f", interactor.totalSpent)
        amountSpentLabel.textColor = interactor.isOverBudget ? UIColor.radical : UIColor.bajaBlast
        
        //Display expenses on tableview
        self.tableView.reloadData()        

    }
    
    //Reload UI with new expense data when the notificationCenter is called
    @objc func reloadUI(notification: NSNotification){
        expenses = interactor.expenses
        fillUI()
    }
  
    //MARK: - UI Creation and Setup
    
    private func configureTableView() {
    
        //Create tableView and add constraints
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 140.0).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = UIColor.zircon
        tableView.separatorStyle = .none
        
        //Register cells
        tableView.register(ExpenseTableViewCell.self, forCellReuseIdentifier: "expenseCell")
    }
    
    private func configureLabels() {
        //Monthly Overview Label
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        monthLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        view.addSubview(monthLabel)
        monthLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        monthLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        
        //Add current month to monthLabel
        let currentMonth = interactor.getCurrentMonthString()
        monthLabel.text = "\(currentMonth) Overview"
        
        //"You spend the most on" Label
        let youSpentLabel = UILabel()
        youSpentLabel.translatesAutoresizingMaskIntoConstraints = false
        youSpentLabel.text = "You spent the most on:"
        youSpentLabel.font = UIFont.systemFont(ofSize: 16.0)
        youSpentLabel.textColor = UIColor.storm
        view.addSubview(youSpentLabel)
        youSpentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        youSpentLabel.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: 30).isActive = true
        youSpentLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        
        //"Total monthly spend:" Label
        let totalMontlyLabel = UILabel()
        totalMontlyLabel.translatesAutoresizingMaskIntoConstraints = false
        totalMontlyLabel.text = "Total monthly spend:"
        totalMontlyLabel.font = UIFont.systemFont(ofSize: 16.0)
        totalMontlyLabel.textColor = UIColor.storm
        view.addSubview(totalMontlyLabel)
        totalMontlyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        totalMontlyLabel.topAnchor.constraint(equalTo: youSpentLabel.bottomAnchor, constant: 12).isActive = true
        totalMontlyLabel.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        
        //Category Label
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.font = UIFont.systemFont(ofSize: 18.0)
        categoryLabel.textAlignment = .right
        view.addSubview(categoryLabel)
        categoryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        categoryLabel.centerYAnchor.constraint(equalTo: youSpentLabel.centerYAnchor).isActive = true
        
        //Amount Spent Label
        amountSpentLabel.translatesAutoresizingMaskIntoConstraints = false
        amountSpentLabel.font = UIFont.systemFont(ofSize: 18.0)
        amountSpentLabel.textColor = UIColor.storm
        amountSpentLabel.textAlignment = .right
        amountSpentLabel.text = "Loading..."
        view.addSubview(amountSpentLabel)
        amountSpentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        amountSpentLabel.centerYAnchor.constraint(equalTo: totalMontlyLabel.centerYAnchor).isActive = true
    }
}

//MARK: - UITableview Setup

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as! ExpenseTableViewCell
        cell.expense = expenses[indexPath.row]
        cell.backgroundColor = UIColor.zircon
        return cell
    }
}
