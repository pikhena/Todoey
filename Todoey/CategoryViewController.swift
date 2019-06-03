//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Priscilla Ikhena on 21/05/2019.
//  Copyright © 2019 Priscilla Ikhena. All rights reserved.
//

import UIKit
import CoreData


class CategoryViewController: UITableViewController {
    
    var categories = [Category]() //an array of category objects
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext //context is what we will use to create, read, destroy our data. It is what will be used to communicate with our persisted container.
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    
    }

    //MARK:- TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
     //MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //triggers when we select one item
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    //MARK: - Data Manipulation Methods
    
    
    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("Error saving category \(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadCategories() {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        
        do{
            categories = try context.fetch(request)
        } catch {
            print("Error loading categories \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    //MARK: - Add New Categories
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categories.append(newCategory)
            
            self.saveCategories()
           
        }
        
        alert.addAction(action)
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new category"
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK: - TableView Datasource Methods
    
    
    //MARK: - Tableview Delegate Methods
}
