//
//  ViewController.swift
//  Todoey
//
//  Created by Priscilla Ikhena on 18/04/2019.
//  Copyright © 2019 Priscilla Ikhena. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    var selectedCategory : Category? {
        didSet{
            loadItems() //,making sure it's being called only when we have a category value
        }
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask) //path to where data is being stored
        
        print(dataFilePath)
        
       
                
       
        
       
        

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
        
        cell.textLabel?.text = item.title
        
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
//
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
       
       
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems() //commits to the actual database.
        
       
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    //MARK Add New Items
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Doey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the add item button on our UI alert.
          
      
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)
            
            self.saveItems()
            
        }
        
     
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
         
           
            
            
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    func saveItems(){
        
        
        do {
           try context.save()
        }
        catch {
          print("Error saving context \(error)")
        }
        
        
        self.tableView.reloadData()
    }
    
    //load Items now shows the data from the SQLLite database to the app.
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil){
       // let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionPredicate])
        } else {
            request.predicate = categoryPredicate
        }

        
        do {
            itemArray = try context.fetch(request)
        }
        
        catch {
            print("Error fetching daya \(error)")
        }
        
        tableView.reloadData()
    }
    
    
}

//MARK: -Search bar methods
extension ToDoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar ) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
         let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
      
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        
        loadItems(with: request, predicate: predicate)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                  searchBar.resignFirstResponder()
            }
          
            
        }
    }
    
    
    
    
}
