
import UIKit

class ToDoListViewController: UITableViewController {
    // creating an array on items according to MVC
    var itemArray = [Item]()
    // provides an interface to file system for directory in domain mask
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)
        
        loadItems()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
        
        // making a property for checkmark
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    // - MARK - add new item Bar
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        // calling an alert window by tapping button
        let alert = UIAlertController(title: "Add new todoItem", message: "", preferredStyle: .alert)
        // button in button, so it will add newItem to out array and tableview
        let action = UIAlertAction(title: "Add!", style: .default) { (action) in
            let newItem = Item() // new item equal to Item model
            newItem.title = textField.text! //name of new item equal to text we wrote in textfield
            self.itemArray.append(newItem) // appending item to out array
            self.saveItems()
        }
        // adding a textField to alert window
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item" // giving a placeholder to textField
            textField = alertTextField
        }
        
        // adding action to alert window
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        print("yyay")
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // making a property for "done"
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
        // making a property for "done"
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // writing a methods that will encode array and write into path. also is will reload our tableView data
    func saveItems() {
        //encoder - new obj
        let encoder = PropertyListEncoder()
        // encoder will encode our plist and write it to file path
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        self.tableView.reloadData() // reloading our table
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
        }
    }
    
    
}
