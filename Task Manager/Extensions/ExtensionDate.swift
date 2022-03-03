//
//  ExtensionDate.swift
//  Task Manager
//
//  Created by Наталья Шарапова on 05.02.2022.
//

import Foundation

extension Date {
    
    // MARK: - Properties
    
    var formatteddate: String {
        
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter.string(from: self)
    }
}
