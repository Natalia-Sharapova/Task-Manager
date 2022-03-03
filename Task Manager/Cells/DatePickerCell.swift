//
//  DatePickerCell.swift
//  Task Manager
//
//  Created by Наталья Шарапова on 24.02.2022.
//

import UIKit

class DatePickerCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet var datePicker: SectionDatePicker!
    
    // MARK: - Properties
    
    var isShown: Bool = true {
        didSet {
            self.datePicker.isHidden = !isShown
        }
    }
}

