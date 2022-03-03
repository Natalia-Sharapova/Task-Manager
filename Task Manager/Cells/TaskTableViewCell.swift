//
//  TaskTableViewCell2.swift
//  Task Manager
//
//  Created by Наталья Шарапова on 19.02.2022.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var stackView: UIStackView!
    
    // MARK: - Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        stackView.arrangedSubviews.forEach { subView in
            stackView.removeArrangedSubview(subView)
            subView.removeFromSuperview()
        }
    }
}


