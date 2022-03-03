//
//  ToDoViewController.swift
//  Task Manager
//
//  Created by Наталья Шарапова on 05.02.2022.
//

import UIKit



class ToDoViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var toDoCollectionView: UICollectionView!
    @IBOutlet weak var groupsCollectionView: UICollectionView!
    
    // MARK: - Properties
    
    private var toDos = [ToDo]()
    private var selectedToDo = ToDo()
    private var groups = [GroupOfTasks]()
    private  var groupCell = GroupCell()
    private var previousIndexPath = IndexPath(item: 0, section: 0)
    private var copiedArray = [ToDo]()
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toDoCollectionView.dataSource = self
        toDoCollectionView.delegate = self
        
        self.groupsCollectionView.register(UINib(nibName: "GroupCell", bundle: nil), forCellWithReuseIdentifier: "GroupCell")
        self.groupsCollectionView.dataSource = self
        self.groupsCollectionView.delegate = self
        
        toDos = [
            ToDo(title: "Buy an apartment", isComplete: false, notes: "Important", dueDate: Date(), image: UIImage(named: "apartment")),
            ToDo(title: "Buy a bread", isComplete: false, notes: "Today", dueDate: Date(), image: UIImage(named: "bread")),
            ToDo(title: "Go to the colleage", isComplete: false, notes: "Not nessesary", dueDate: Date(), image: UIImage(named: "colleage")),
            ToDo(title: "Buy notebook", isComplete: false, notes: "Only Apple", dueDate: Date(), image: UIImage(named: "notebook")),
            ToDo(title: "Make a dinner", isComplete: false, notes: "Tasty!", dueDate: Date(), image: UIImage(named: "dinner")),
            ToDo(title: "Take a luggage", isComplete: false, notes: "For Moscow", dueDate: Date(), image: UIImage(named: "luggage")),
            ToDo(title: "Go to the GYM", isComplete: false, notes: "Take 50kg", dueDate: Date(), image: UIImage(named: "GYM")),
            ToDo(title: "Buy a ticket", isComplete: false, notes: "Tomorrow", dueDate: Date(), image: UIImage(named: "ticket")),
            ToDo(title: "Buy a fireplace", isComplete: false, notes: "Warm", dueDate: Date(), image: UIImage(named: "fireplace"))
        ]
        
        let group01 = GroupOfTasks(name: "Important", listOfTasks: toDos)
        let group02 = GroupOfTasks(name: "Today", listOfTasks: toDos)
        let group03 = GroupOfTasks(name: "Tomorrow", listOfTasks: toDos)
        let group04 = GroupOfTasks(name: "This month", listOfTasks: toDos)
        let group05 = GroupOfTasks(name: "This year", listOfTasks: toDos)
        let group06 = GroupOfTasks(name: "Not urgent", listOfTasks: toDos)
        
        groups = [group01, group02, group03, group04, group05, group06]
        
    }
    
    func copy(_ array: [ToDo]) -> [ToDo] {
        
        let copiedArrayToDo =
            [
                ToDo(title: "Buy an apartment", isComplete: false, notes: "Important", dueDate: Date(), image: UIImage(named: "apartment")),
                ToDo(title: "Buy a bread", isComplete: false, notes: "Today", dueDate: Date(), image: UIImage(named: "bread")),
                ToDo(title: "Go to the colleage", isComplete: false, notes: "Not nessesary", dueDate: Date(), image: UIImage(named: "colleage")),
                ToDo(title: "Buy notebook", isComplete: false, notes: "Only Apple", dueDate: Date(), image: UIImage(named: "notebook")),
                ToDo(title: "Make a dinner", isComplete: false, notes: "Tasty!", dueDate: Date(), image: UIImage(named: "dinner")),
                ToDo(title: "Take a luggage", isComplete: false, notes: "For Moscow", dueDate: Date(), image: UIImage(named: "luggage")),
                ToDo(title: "Go to the GYM", isComplete: false, notes: "Take 50kg", dueDate: Date(), image: UIImage(named: "GYM")),
                ToDo(title: "Buy a ticket", isComplete: false, notes: "Tomorrow", dueDate: Date(), image: UIImage(named: "ticket")),
                ToDo(title: "Buy a fireplace", isComplete: false, notes: "Warm", dueDate: Date(), image: UIImage(named: "fireplace"))
            ]
        return copiedArrayToDo
    }
    
    // MARK: - Navigation
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        
        guard segue.identifier == "SaveSegue" else { return }
        
        let source = segue.source as! ToDoItemTableViewController
        
        selectedToDo = source.toDo
        
        // Notification for reload data in tableView
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "remove"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    // Scrolling collection view simultaneously with another and making groupCell is selected when you tap on it
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        guard scrollView == toDoCollectionView else { return }
        
        guard let groupCell = groupsCollectionView.cellForItem(at: previousIndexPath) as? GroupCell else { return }
        groupCell.isSelected = false
        
        targetContentOffset.pointee = scrollView.contentOffset
        
        var indexPaths = toDoCollectionView.indexPathsForVisibleItems
        
        indexPaths.sort()
        
        var indexPath = indexPaths.first!
        
        let cell = toDoCollectionView.cellForItem(at: indexPath) as! ToDoCollectionViewCell
        
        let position = toDoCollectionView.contentOffset.x - cell.frame.origin.x
        
        if position > cell.frame.size.width / 2 {
            indexPath.row = indexPath.row + 1
        }
        
        toDoCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        groupsCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        guard let groupCell = groupsCollectionView.cellForItem(at: indexPath) as? GroupCell else { return }
        groupCell.isSelected = true
        
        previousIndexPath = indexPath
    }
}

// MARK: - Extensions

extension ToDoViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return groups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == groupsCollectionView {
            let cell = groupsCollectionView.dequeueReusableCell(withReuseIdentifier: "GroupCell", for: indexPath) as! GroupCell
            
            let group = groups[indexPath.item]
            
            cell.setupCell(group: group)
            
            if indexPath == [0,0] {
                
                cell.isSelected = true
            }
            return cell
            
        } else {
            
            let cell = toDoCollectionView.dequeueReusableCell(withReuseIdentifier: "ToDoCollectionViewCell", for: indexPath) as! ToDoCollectionViewCell
            
            cell.delegate = self
            
            let copiedArray = copy(groups[indexPath.item].listOfTasks)
            
            cell.setupCollectionViewCell(toDo: copiedArray)
            
            return cell
        }
    }
}

extension ToDoViewController: UICollectionViewDelegate {}

extension ToDoViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Make group name with width of the font
        if collectionView == groupsCollectionView {
            let groupName = groups[indexPath.item].name
            let width = groupName.widthOfString(usingFont: UIFont(name: "Gill Sans", size: 19) ?? UIFont.systemFont(ofSize: 17))
            
            return CGSize(width: width + 20, height: collectionView.frame.height)
            
        } else {
            
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }
    
    // Distance between sections
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // Itsets for each section from the right and left side
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard collectionView == groupsCollectionView else { return }
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        toDoCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        let group = groups[indexPath.item]
        navigationItem.title = group.name
    }
}

extension ToDoViewController: ToDoViewControllerDelegate {
    
    //Delegate function
    
    func didSelectIndex(toDo: ToDo) {
        
        self.selectedToDo = toDo
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let toDoItemTableViewController = storyboard.instantiateViewController(withIdentifier: "ToDoItem") as! ToDoItemTableViewController
        
        toDoItemTableViewController.toDo = selectedToDo
        
        self.navigationController!.pushViewController(toDoItemTableViewController, animated: true)
    }
}






