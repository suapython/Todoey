//
//  ViewController.swift
//  Todoey
//
//  Created by jose francisco morales on 20/06/2019.
//  Copyright © 2019 jose francisco morales. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Find mike", "Buy Eggs", "Destroy dragons","fight against elfs" ]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [String]
        {
            itemArray = items
        }
    }
    
  //Mark -Tableview datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //Mark -tableview delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // mark add new item

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "",preferredStyle: .alert)
        let action = UIAlertAction(title:"Add Item", style: .default) { (action) in
      //what will happer once clicks the add item button
        self.itemArray.append(textField.text!)
            
        self.defaults.set(self.itemArray, forKey:"ToDoListArray")
            
        self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true,completion:  nil)
    }
    
}




