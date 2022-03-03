//
//  ToDoItemTableViewController.swift
//  Task Manager
//
//  Created by Наталья Шарапова on 13.02.2022.
//

import UIKit

class ToDoItemTableViewController: UITableViewController, UINavigationControllerDelegate {
    
    // MARK: - Properties
    
    var toDo = ToDo()
    private let datePickerIndexPath = IndexPath(row: 1, section: 3)
    private let dateLabelIndexPath = IndexPath(row: 0, section: 3)
    private var isDatePickerShown: Bool = true
    
}

// MARK: - Extensions

extension ToDoItemTableViewController /*: UITableViewDataSourse */ {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath {
        
        case datePickerIndexPath:
            return isDatePickerShown ? UITableView.automaticDimension : 0
            
        default:
            return UITableView.automaticDimension
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return toDo.keys.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let value = toDo.values[section]
        
        return value is Date ? 2 : 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = indexPath.section
        
        let value = toDo.values[section]
        
        let cell = getCellFor(indexPath: indexPath, with: value)
        
        return cell 
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let key = toDo.capitalizedKeys[section]
        
        return key
    }
}

extension ToDoItemTableViewController /*: UITableViewDelegate */ {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let value = toDo.values[indexPath.section]
        
        if value is Date {
            
            if indexPath.row == 0 {
                if let datePicker = tableView.cellForRow(at: datePickerIndexPath) as? DatePickerCell {
                    
                    datePicker.isShown.toggle()
                    isDatePickerShown.toggle()
                }
            }
            
        } else if value is UIImage {
            
            let alert = UIAlertController(title: "Choose source", message: nil, preferredStyle: .actionSheet)
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            alert.addAction(cancel)
            
            let imagePicker = SectionImagePickerController()
            imagePicker.delegate = self
            imagePicker.section = indexPath.section
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
                    imagePicker.sourceType = .camera
                    self.present(imagePicker, animated: true)
                }
                alert.addAction(cameraAction)
            }
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let libraryAction = UIAlertAction(title: "Library", style: .default) { action in
                    imagePicker.sourceType = .photoLibrary
                    self.present(imagePicker, animated: true)
                }
                alert.addAction(libraryAction)
            }
            present(alert, animated: true)
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

// MARK: - Cell configuration

extension ToDoItemTableViewController {
    
    func getCellFor(indexPath: IndexPath, with value: Any?) -> UITableViewCell {
        
        if let stringValue = value as? String {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell") as! TextFieldCell
            
            cell.textField.addTarget(self, action: #selector(textFieldValueChanged(_:)), for: .editingChanged)
            cell.textField.section = indexPath.section
            cell.textField.text = stringValue
            return cell
            
        } else if let dateValue = value as? Date {
            
            switch  indexPath.row {
            
            case 0:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell") as! DateCell
                
                cell.label.text = dateValue.formatteddate
                
                return cell
                
            case 1:
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "DatePickerCell") as! DatePickerCell
                
                cell.datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
                cell.datePicker.section = indexPath.section
                cell.datePicker.date = dateValue
                cell.datePicker.minimumDate = Date()
                return cell
                
            default:
                fatalError("Please add more prototype cells for date section")
            }
            
        } else if let boolValue = value as? Bool {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell") as! SwitchCell
            cell.switch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
            cell.switch.isOn = boolValue
            cell.switch.section = indexPath.section
            
            return cell
            
        } else if let imageValue = value as? UIImage {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell") as! ImageCell
            
            cell.largeImageView.image = imageValue
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell") as! TextFieldCell
            
            cell.textField.addTarget(self, action: #selector(textFieldValueChanged(_:)), for: .editingChanged)
            cell.textField.text = ""
            cell.textField.section = indexPath.section
            
            return cell
        }
    }
}

// MARK: - Actions

extension ToDoItemTableViewController {
    
    // Set new values for the toDo item
    
    @objc func datePickerValueChanged(_ sender: SectionDatePicker) {
        let section = sender.section!
        let key = toDo.keys[section]
        
        let date = sender.date
        toDo.setValue(date, forKey: key)
        
        // Reload the dateLabel data
        let labelIndexPath = IndexPath(row: 0, section: section)
        tableView.reloadRows(at: [labelIndexPath], with: .automatic)
        
    }
    
    @objc func switchValueChanged(_ sender: SectionSwitch) {
        
        let key = toDo.keys[sender.section]
        let value = sender.isOn
        
        toDo.setValue(value, forKey: key)
    }
    
    @objc func textFieldValueChanged(_ sender: SectionTextField) {
        
        let key = toDo.keys[sender.section]
        let text = sender.text ?? ""
        
        toDo.setValue(text, forKey: key)
    }
}

extension ToDoItemTableViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        dismiss(animated: true)
        
        guard let image = info[.originalImage] else { return }
        guard let sectionPicker = picker as? SectionImagePickerController else { return }
        guard let section = sectionPicker.section else { return }
        
        let key = toDo.keys[section]
        
        toDo.setValue(image, forKey: key)
        
        let indexPath = IndexPath(row: 0, section: section)
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
