//
//  ViewController.swift
//  Todoey
//
//  Created by Priscilla Ikhena on 18/04/2019.
//  Copyright © 2019 Priscilla Ikhena. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [taskClass]()
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = taskClass()
        newItem.taskName = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = taskClass()
        newItem2.taskName = "Buy Eggs"
        itemArray.append(newItem2)
        
        let newItem3 = taskClass()
        newItem3.taskName = "Buy Salt"
        itemArray.append(newItem3)
        
       
        
        
        
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [taskClass] {
            itemArray = items
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK - TableView Datasource Methods
    //
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       // let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        
      let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
       
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.taskName
        
        //using a ternary operator
        //value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
        //this line expresses the commented if and else statement below.
        
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        }
//
//        else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
   //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    //MARK Add New Items
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Doey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the add item button on our UI alert.
          
            let newItem = taskClass()
            newItem.taskName = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
            
           
            
            
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    
   
    
    
    
}

