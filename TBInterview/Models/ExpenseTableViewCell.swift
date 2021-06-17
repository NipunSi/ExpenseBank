//
//  ExpenseTableViewCell.swift
//  TBInterview
//
//  Created by Nipun Singh on 6/16/21.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {
    
    //Fill tableview cell with data from respective Expense object
    var expense: Expense? {
        didSet {
            guard let expenseItem = expense else { return }
            
            titleLabel.text = expense?.title
            amountLabel.text = String(format: "$%.2f", expense?.amount ?? 0.00)
            
            if let category = expenseItem.category {
                categoryLabel.text = category.capitalized
            }
        }
    }
    

    //Initialize cell and add labels with constraints
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(backgroundContainerView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(categoryLabel)
        self.contentView.addSubview(amountLabel)
        
        backgroundContainerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant: 8).isActive = true
        backgroundContainerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant: -8).isActive = true
        backgroundContainerView.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant: 8).isActive = true
        backgroundContainerView.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant: -8).isActive = true

        titleLabel.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor, constant: -12).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant: 24).isActive = true
        
        categoryLabel.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor, constant: 12).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant: 24).isActive = true
        
        amountLabel.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        amountLabel.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant: -16).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //Setup the expenseCell's labels
    let backgroundContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.storm
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = UIColor.storm
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()  
}
