//
//  ViewController.swift
//  Todoey
//
//  Created by jose francisco morales on 20/06/2019.
//  Copyright © 2019 jose francisco morales. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
       print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) )
        
        print(dataFilePath!)
        
       
       loadItems()
        
        
        
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
        
       
        //context.delete(itemArray[indexPath.row])
        //itemArray.remove(at: indexPath.row)
        
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
            
            
        let newItem = Item(context: self.context)
        newItem.title = textField.text!
        newItem.done = false
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
    
    
    
    do {
        try  context.save()
    } catch {
        print("Error saving context ,\(error)")
        
    }
    
    
    tableView.reloadData()
}
    
    func loadItems() {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
           itemArray = try context.fetch(request)
        }
        catch {
           print("Error fetching \(error)")
        }
    }

}

