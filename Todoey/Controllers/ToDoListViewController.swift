
import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    // creating an array on items according to MVC
    var itemArray = [Item]()
    // provides an interface to file system for directory in domain mask
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
            
    
            let newItem = Item(context: self.context)  // new item equal to Item model
            newItem.title = textField.text! //name of new item equal to text we wrote in textfield
            newItem.done = false
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
    func loadItems() {
        //here we have to write NSFetchRequest just because
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do{
            itemArray = try context.fetch(request)
        } catch {
            print("error")
        }
    }
    
}
