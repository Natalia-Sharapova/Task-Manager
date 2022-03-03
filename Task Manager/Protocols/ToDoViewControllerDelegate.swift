//
//  ToDoViewControllerDelegate.swift
//  Task Manager
//
//  Created by Наталья Шарапова on 27.02.2022.
//

import Foundation

protocol ToDoViewControllerDelegate {
    
    func didSelectIndex(toDo: ToDo)
}
