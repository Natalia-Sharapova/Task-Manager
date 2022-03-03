//
//  ToDo.swift
//  Task Manager
//
//  Created by Наталья Шарапова on 20.02.2022.
//

import Foundation
import UIKit

struct GroupOfTasks {
    
    var name: String
    var listOfTasks: [ToDo]
}


@objcMembers class ToDo: NSObject {
    
    var title: String
    var isComplete: Bool
    var notes: String?
    var dueDate: Date
    var image: UIImage?
    
    init(
        title: String = "",
        isComplete: Bool = false,
        notes: String? = nil,
        dueDate: Date = Date(),
        image: UIImage? = nil
        
    ) {
        
        self.title = title
        self.isComplete = isComplete
        self.notes = notes
        self.dueDate = dueDate
        self.image = image
    }
    
    override func copy() -> Any {
        
        let newToDo = ToDo(title: title,
                           isComplete: isComplete,
                           notes: notes,
                           dueDate: dueDate,
                           image: image?.copy() as? UIImage)
        return newToDo
    }
    
    
    var capitalizedKeys: [String] {
        return keys.map { $0.capitalizedWithSpaces }
    }
    
    
    var keys: [String] {
        
        return Mirror(reflecting: self).children.compactMap { $0.label }
    }
    
    var values: [Any?] {
        
        return Mirror(reflecting: self).children.map { $0.value }
    }
}
