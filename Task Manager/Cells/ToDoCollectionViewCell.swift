//
//  ToDoCollectionViewCell2.swift
//  Task Manager
//
//  Created by Наталья Шарапова on 19.02.2022.
//

import UIKit

class ToDoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var toDoTableView: UITableView!
    
    // MARK: - Properties
    
    var delegate: ToDoViewControllerDelegate?
    
    private var toDoArray = [ToDo]()
    
    private var selectedIndex = IndexPath(row: 0, section: 0)
    
    private var selectedToDo = ToDo()
    
    override func awakeFromNib() {
        
        toDoTableView.dataSource = self
        toDoTableView.delegate = self
        
        // Notifications for reload data in tableView
        NotificationCenter.default.addObserver(self, selector: #selector(tableViewReloadData), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(removeStackViews), name: NSNotification.Name(rawValue: "remove"), object: nil)
    }
    
    // MARK: - Methods
    
    @objc func removeStackViews(notification: NSNotification){
        
        if let toDoCell = toDoTableView.cellForRow(at: selectedIndex) as? TaskTableViewCell {
            
            if let stackView = toDoCell.stackView {
                stackView.arrangedSubviews.forEach { subView in
                    stackView.removeArrangedSubview(subView)
                    subView.removeFromSuperview()
                }
            }
        }
    }
    
    @objc func tableViewReloadData(notification: NSNotification) {
        
        self.toDoTableView.reloadRows(at: [selectedIndex], with: .automatic)
        
    }
    
    // Get toDo
    func setupCollectionViewCell(toDo: [ToDo]) {
        
        self.toDoArray = toDo
        
        toDoTableView.reloadData()
    }
}

// MARK: - Extensions

extension ToDoCollectionViewCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Get selected to do
        selectedToDo = toDoArray[indexPath.row]
        
        // Call delegate
        delegate?.didSelectIndex(toDo: selectedToDo)
    }
}

extension ToDoCollectionViewCell: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return toDoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        
        let toDo = toDoArray[indexPath.row]
        
        setupTableViewCell(cell, with: toDo)
        
        return cell
    }
    
    func setupTableViewCell(_ cell: TaskTableViewCell, with toDo: ToDo) {
        
        guard let stackView = cell.stackView else { return }
        guard stackView.arrangedSubviews.count == 0 else { return }
        
        for index in 0 ..< toDo.keys.count {
            
            let key = toDo.capitalizedKeys[index]
            
            let value = toDo.values[index]
            
            if let stringValue = value as? String {
                
                let label = UILabel()
                label.text = "\(key) : \(stringValue)"
                label.font = UIFont(name: "Gill Sans", size: 20)
                
                stackView.addArrangedSubview(label)
                
            } else if let dateValue = value as? Date {
                
                let label = UILabel()
                label.text = "\(key) : \(dateValue.formatteddate)"
                label.font = UIFont(name: "Gill Sans", size: 20)
                
                stackView.addArrangedSubview(label)
                
            } else if let boolValue = value as? Bool {
                
                let label = UILabel()
                
                label.text = "\(key) : \(boolValue ? "✔️" : "🔲")"
                label.font = UIFont(name: "Gill Sans", size: 20)
                
                stackView.addArrangedSubview(label)
                
            } else if let imageValue = value as? UIImage {
                
                let imageView = UIImageView(image: imageValue)
                
                let heightConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 100)
                
                imageView.contentMode = .scaleAspectFit
                
                imageView.addConstraint(heightConstraint)
                stackView.addArrangedSubview(imageView)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 300
    }
}


