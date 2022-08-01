//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = ["Buy eggs", "wash table", "destroy Demogorgon"]
    
    // 1. создаем UserDefaulets для хранения массива в памяти телефона
    let defaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 3. добавляем сохраненный из памяти массив на экран загрузки
        if let arr = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = arr
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let b = itemArray.count
        return b
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK - add new item Bar
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new todoItem", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add!", style: .default) { (alert) in
            
            if let itBe = textField.text {
                self.itemArray.append(itBe)
                self.tableView.reloadData()
            } else {
                print("lol")
            }
            //2. Сохраняем наш новый массив в юзерДефолтс под ключем ТуДуЛистЭрэй
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")

        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        print("yyay")
        
    }
    
    
}

extension ToDoListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print("\(itemArray[indexPath.row])")
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

