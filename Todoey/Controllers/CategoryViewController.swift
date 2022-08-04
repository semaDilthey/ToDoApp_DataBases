//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Семен Гайдамакин on 05.08.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
    }

    // MARK: - Table add buttons


    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        // calling an alert window by tapping button
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        // button in button, so it will add newItem to out array and tableview
        let action = UIAlertAction(title: "Add!", style: .default) { (action) in
            
    
            let newCategory = Category(context: self.context)  // new item equal to Item model
            newCategory.name = textField.text! //name of new item equal to text we wrote in textfield
            
            self.categoryArray.append(newCategory) // appending item to out array
            self.saveItems()
        }
        // adding a textField to alert window
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category" // giving a placeholder to textField
            textField = alertTextField
        }
        
        // adding action to alert window
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        print("yyay")
        
    }

    
    // MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray.count
        
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
            
        let category = categoryArray[indexPath.row]
            
        cell.textLabel?.text = category.name
            
            return cell
        }
    
    // MARK: - Data Manipulation Methods (save/load)
    
    // this func saving new items to data base
    func saveItems() {
       
        do {
           try context.save()
        } catch {
            print("Error \(error)")
        }
        self.tableView.reloadData() // reloading our table
    }
    
    //this func load existing items to our screen
    func loadItems(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        //here we have to write NSFetchRequest just because
    
        do{
            categoryArray = try context.fetch(request)
        } catch {
            print("error")
        }
        
        tableView.reloadData()
    }
}

// MARK: - Tableview Delegate Methods
