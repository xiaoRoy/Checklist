//
//  ViewController.swift
//  Checklist
//
//  Created by Jerry Li on 2019/2/23.
//  Copyright © 2019 Jerry Li. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {
    
    var checkListItemArray: Array = [ChecklistItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        navigationController?.navigationBar.prefersLargeTitles = true
//        let todos = ["Walk the dog", "Brush my teeth", "Learn iOS develoment",
//                     "Soccer practice", "Eat ice cream"]
//        for todo in todos {
//            let checkListItem = ChecklistItem()
//            checkListItem.todo = todo
//            checkListItemArray.append(checkListItem)
//        }
//        print("Document folder is \(documentsDirectory())")
//        print("Data file path is \(dataFilePath())")
//        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL{
        return documentsDirectory().appendingPathComponent("CheckList.plist")
    }
    
    func saveChecklistItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(checkListItemArray)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding tiem arry: \(error.localizedDescription)")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! ItemDatialViewController
            controller.itemDetailViewControllerDelegate = self
        } else if segue.identifier == "EditItem" {
            let controller = segue.destination as! ItemDatialViewController
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = checkListItemArray[indexPath.row]
            }
        }
    }
    
    // MARK:- Table View Data Source
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return checkListItemArray.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem",
                                                 for: indexPath)
        let item = getCheckListItem(at: indexPath)
        configureCheckMark(for: cell, with: item)
        configureLabel(for: cell, with: item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        checkListItemArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        saveChecklistItems()
    }
    
    // MARK:- Table View Delegate
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = getCheckListItem(at: indexPath)
            item.toggle()
            configureCheckMark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        saveChecklistItems()
    }
    
    // MARK:- Add Item View Controller Delegates
    func itemDetailViewControllerDidCancle(_ controller: ItemDatialViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDatialViewController, didFinishAdding item: ChecklistItem) {
        addItemViewForController(controller, didFinishItem: item)
        saveChecklistItems()
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewController(_ controller: ItemDatialViewController, didFininishEditing item: ChecklistItem) {
        if let index = checkListItemArray.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureLabel(for: cell, with: item)
            }
        }
        saveChecklistItems()
        navigationController?.popViewController(animated: true)
    }
    
    
    //MARK:- Setup Cell
    func getCheckListItem(at indexPath: IndexPath) -> ChecklistItem {
        return checkListItemArray[indexPath.row % checkListItemArray.count]
    }
    
    func configureLabel(for cell: UITableViewCell,
                        with item: ChecklistItem) {
        if let label = cell.viewWithTag(1000) as? UILabel {
            label.text = item.todo
        }
//        let label = cell.viewWithTag(1000) as! UILabel
//        label.text = item.todo
    }
    
    func configureCheckMark(for cell: UITableViewCell,
                            with item: ChecklistItem) {
        if let label = cell.viewWithTag(1001) as? UILabel {
            label.text = item.completed ? "√" : ""
        }
    }
    
    private func addItemViewForController(_ addItemViewController: ItemDatialViewController, didFinishItem item: ChecklistItem) {
        
        let newIndex = checkListItemArray.count
        checkListItemArray.append(item)
        
        let indexPath = IndexPath(row: newIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with:.automatic)
    }
}

