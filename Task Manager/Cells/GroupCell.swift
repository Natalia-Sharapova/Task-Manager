//
//  GroupCell.swift
//  Task Manager
//
//  Created by Наталья Шарапова on 06.02.2022.
//

import UIKit

class GroupCell: UICollectionViewCell {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameGroup: UILabel!
    
    // MARK: - Properties
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.layer.borderWidth = 1
                self.layer.borderColor = UIColor.cyan.cgColor
                self.layer.cornerRadius = 15
            } else {
                self.layer.borderWidth = 0
            }
        }
    }
    
    // MARK: - Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        isSelected = false
    }
    
    func setupCell(group: GroupOfTasks) {
        
        let nameOfGroup = group.name
        nameGroup.text = nameOfGroup
        nameGroup.font = UIFont(name: "Gill Sans", size: 19)
    }
}
