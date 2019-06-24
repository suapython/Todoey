//
//  ViewController.swift
//  Todoey
//
//  Created by jose francisco morales on 20/06/2019.
//  Copyright © 2019 jose francisco morales. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        
        print(dataFilePath)
        
        
       let newitem = Item()
        newitem.title = "Find Mike"
        itemArray.append(newitem)
        
        let newitem2 = Item()
        newitem2.title = "Buy eggs"
        itemArray.append(newitem2)
        
        let newitem3 = Item()
        newitem3.title = "Find car"
        itemArray.append(newitem3)
        
       if let items = defaults.array(forKey: "ToDoListArray") as? [Item]
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
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : . none
        
        return cell
    }
    
    //Mark -tableview delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
       itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    // mark add new item

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todoey item", message: "",preferredStyle: .alert)
        let action = UIAlertAction(title:"Add Item", style: .default) { (action) in
      //what will happer once clicks the add item button
            
        
        let newItem = Item()
            newItem.title = textField.text!
            
        self.itemArray.append(newItem)
            
       self.saveItems()
            
            
        }
        alert.addTextField { (alertTextField) in alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true,completion:  nil)
    }
    


func saveItems() {
    
    let encoder = PropertyListEncoder()
    
    do {
        let data = try encoder.encode(itemArray)
        try data.write(to: dataFilePath!)
    } catch {
        print("Error encoding item array ,\(error)")
        
    }
    
    
    tableView.reloadData()
}

}
